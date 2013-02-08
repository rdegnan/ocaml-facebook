open Lwt
open Printf
open Facebook_t

(* Various useful URI generation functions, normally for displaying on a web-page.
 * The [authorize] function is the entry URL for your users, and the [token] URI
 * is the URI used to convert the result into a concrete access token *)
module URI = struct
  let token ~client_id ~client_secret () =
    let uri = Uri.of_string "https://graph.facebook.com/oauth/access_token" in
    let q = [ "client_id", client_id; "client_secret", client_secret; "grant_type", "client_credentials" ] in
    Uri.with_query' uri q

  let user ?(id="me") ?items () =
    Uri.of_string (match items with
      | None -> sprintf "https://graph.facebook.com/%s" id
      | Some items -> sprintf "https://graph.facebook.com/%s/%s" id items
    )

  let opengraph ?(id="me") ?(namespace="og") ~action () =
    Uri.of_string (sprintf "https://graph.facebook.com/%s/%s:%s" id namespace action)
end

module C = Cohttp
module CL = Cohttp_lwt_unix
module CLB = CL.Body

module Monad = struct
  (* Each API call results in either a valid response or
   * an HTTP error. Depending on the error status code, it may
   * be retried within the monad, or a permanent failure returned *)
  type error =
    | Api of api_error
    | Generic of CL.Response.t
    | No_response
    | Bad_response of exn
  and 'a response =
    | Error of error
    | Response of 'a
  and 'a t = 'a response Lwt.t

  let error_to_string = function
    | Api err -> sprintf "%s %d: %s" err.kind err.code err.message
    | Generic res -> sprintf "HTTP Error %s" (C.Code.string_of_status (CL.Response.status res))
    | No_response -> "No response"
    | Bad_response exn -> sprintf "Bad response: %s\n" (Printexc.to_string exn)

  let bind x fn = match_lwt x with
    | Error e -> return (Error e)
    | Response r -> fn r

  let return r = return (Response r)

  let run th = match_lwt th with
    | Response r -> Lwt.return r
    | Error e -> fail (Failure (error_to_string e))

  let (>>=) = bind
end

module API = struct
   (* Add an authorization token onto a request URI and parse the response as JSON. *)
  let request_with_token ?headers ?token ?(params=[]) ~expected_code uri reqfn respfn =
    let uri = Uri.add_query_params' uri params in
    (* Add the correct mime-type header *)
    let headers = match headers with
      | Some x -> Some (C.Header.add x "content-type" "application/json")
      | None -> Some (C.Header.of_list ["content-type","application/json"]) in
    let uri = match token with
      | Some token -> Uri.add_query_param uri ("access_token", [token])
      | None -> uri in
    match_lwt (reqfn ?headers) uri with
      | None -> return (Monad.(Error No_response))
      | Some (res,body) ->
          if CL.Response.status res = expected_code then
            try_lwt
              lwt r = CLB.string_of_body body >>= respfn in
              return (Monad.Response r)
            with exn -> return (Monad.(Error (Bad_response exn)))
          else
            try_lwt
              lwt r = CLB.string_of_body body >|= Facebook_j.error_of_string in
              return Monad.(Error (Api r.error))
            with _ -> return (Monad.(Error (Generic res)))

  (* Convert a request body into a stream and force chunked-encoding *)
  let request_with_token_body ?headers ?token ?body ?params ~expected_code uri req resp =
    let body = match body with
      | None -> None
      | Some b -> CLB.body_of_string b in
    let chunked = Some false in
    request_with_token ?headers ?token ?params ~expected_code uri (req ?body ?chunked) resp

  let get ?headers ?token ?(params=[]) ?(expected_code=`OK) ~uri fn =
    request_with_token ?headers ?token ~params ~expected_code uri CL.Client.get fn

  let post ?headers ?body ?token ?(params=[]) ?(expected_code=`OK) ~uri fn =
    request_with_token_body ?headers ?token ?body ~params ~expected_code uri CL.Client.post fn

  let delete ?headers ?token ?(params=[]) ?(expected_code=`No_content) ~uri fn =
    request_with_token ?headers ?token ~params ~expected_code uri CL.Client.delete fn
end

module Token = struct
  type t = string

  let request ~client_id ~client_secret () =
    let uri = URI.token ~client_id ~client_secret () in
    match_lwt CL.Client.get uri with
      | None -> return None
      | Some (res, body) ->
          lwt body = CLB.string_of_body body in
          try
            let form = Uri.query_of_encoded body in
            return (Some (List.(hd (assoc "access_token" form))))
          with _ ->
            return None

  let of_string x = x
  let to_string x = x
end

module User = struct
  let get ?token ?id ?(fields=[]) () =
    let uri = URI.user ?id () in
    let params = ["fields", String.concat "," fields] in
    API.get ?token ~uri ~params (wrap1 Facebook_j.user_of_string)

  let likes ?token ?id ?(fields=[]) ?(limit=0) () =
    let uri = URI.user ?id ~items:"likes" () in
    let params =
      ["fields", String.concat "," fields]
      @
      (if limit <= 0 then [] else ["limit", string_of_int limit])
    in
    API.get ?token ~uri ~params
      (wrap1 (fun x ->
        Printf.printf "<><><><><><><> %s"x;
        let likes = (Facebook_j.like_data_of_string x).liked_data in
        match likes with None -> [] | Some l -> l))

end

module OpenGraph = struct
  let post ?token ?id ?namespace ~action ?(params=[]) () =
    let uri = URI.opengraph ?id ?namespace ~action () in
    API.post ?token ~uri ~params (wrap1 Facebook_j.og_object_of_string)
end
