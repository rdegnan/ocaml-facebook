(* All API requests are bound through this monad. The [run] function
 * will unpack an API response into an Lwt thread that will hold the
 * ultimate response. *)
module Monad : sig
  type 'a t
  val bind : 'a t -> ('a -> 'b t) -> 'b t
  val return : 'a -> 'a t
  val run : 'a t -> 'a Lwt.t
  val (>>=) : 'a t -> ('a -> 'b t) -> 'b t
end

(* Access token to the API, usually obtained via a user oAuth *)
module Token : sig
  type t
  val request: client_id:string -> client_secret:string -> unit -> t option Lwt.t
  val to_string : t -> string
  val of_string : string -> t
end

(* Generic API accessor function, not normally used directly, but useful in case you
 * wish to call an API call that isn't wrapped in the rest of the library (i.e. most
 * of them at the moment!)
 *)
module API : sig
  val get :
    ?headers:Cohttp.Header.t ->
    ?token:Token.t ->
    ?params:(string * string) list ->
    ?expected_code:Cohttp.Code.status_code ->
    uri:Uri.t ->
    (string -> 'a Lwt.t) -> 'a Monad.t

  val post :
    ?headers:Cohttp.Header.t ->
    ?body:string ->
    ?token:Token.t ->
    expected_code:Cohttp.Code.status_code ->
    uri:Uri.t ->
    (string -> 'a Lwt.t) -> 'a Monad.t

   val delete :
    ?headers:Cohttp.Header.t ->
    ?token:Token.t ->
    ?params:(string * string) list ->
    ?expected_code:Cohttp.Code.status_code ->
    uri:Uri.t ->
    (string -> 'a Lwt.t) -> 'a Monad.t
end

(* Various useful URI generation functions, normally for displaying on a web-page.
 * The [authorize] function is the entry URL for your users, and the [token] URI
 * is the URI used to convert the result into a concrete access token *)
module URI : sig
  val token : client_id:string -> client_secret:string -> unit -> Uri.t
end

module User : sig
  val get:
    ?token:Token.t ->
    ?id:string -> ?fields:string list -> unit -> Facebook_t.user Monad.t
end
