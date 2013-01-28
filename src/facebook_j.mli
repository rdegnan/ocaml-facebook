(* Auto-generated from "facebook.atd" *)


type api_error = Facebook_t.api_error = {
  message: string;
  kind: string;
  code: int
}

type error = Facebook_t.error = { error: api_error }

type graph_object = Facebook_t.graph_object = { id: string; name: string }

type picture_data = Facebook_t.picture_data = {
  url: string;
  is_silhouette: bool
}

type picture = Facebook_t.picture = { data: picture_data }

type user = Facebook_t.user = {
  user_id (*atd id *): string;
  user_name (*atd name *): string option;
  user_first_name (*atd first_name *): string option;
  user_middle_name (*atd middle_name *): string option;
  user_last_name (*atd last_name *): string option;
  user_gender (*atd gender *): string option;
  user_locale (*atd locale *): string option;
  user_link (*atd link *): string option;
  user_username (*atd username *): string option;
  user_installed (*atd installed *): bool option;
  user_timezone (*atd timezone *): int option;
  user_updated_time (*atd updated_time *): string option;
  user_verified (*atd verified *): bool option;
  user_bio (*atd bio *): string option;
  user_birthday (*atd birthday *): string option;
  user_email (*atd email *): string option;
  user_location (*atd location *): graph_object option;
  user_political (*atd political *): string option;
  user_picture (*atd picture *): picture option;
  user_quotes (*atd quotes *): string option;
  user_religion (*atd religion *): string option
}

type og_object = Facebook_t.og_object = {
  og_id (*atd id *): string;
  og_photos (*atd photos *): string list
}

val write_api_error :
  Bi_outbuf.t -> api_error -> unit
  (** Output a JSON value of type {!api_error}. *)

val string_of_api_error :
  ?len:int -> api_error -> string
  (** Serialize a value of type {!api_error}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_api_error :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> api_error
  (** Input JSON data of type {!api_error}. *)

val api_error_of_string :
  string -> api_error
  (** Deserialize JSON data of type {!api_error}. *)

val write_error :
  Bi_outbuf.t -> error -> unit
  (** Output a JSON value of type {!error}. *)

val string_of_error :
  ?len:int -> error -> string
  (** Serialize a value of type {!error}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_error :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> error
  (** Input JSON data of type {!error}. *)

val error_of_string :
  string -> error
  (** Deserialize JSON data of type {!error}. *)

val write_graph_object :
  Bi_outbuf.t -> graph_object -> unit
  (** Output a JSON value of type {!graph_object}. *)

val string_of_graph_object :
  ?len:int -> graph_object -> string
  (** Serialize a value of type {!graph_object}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_graph_object :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> graph_object
  (** Input JSON data of type {!graph_object}. *)

val graph_object_of_string :
  string -> graph_object
  (** Deserialize JSON data of type {!graph_object}. *)

val write_picture_data :
  Bi_outbuf.t -> picture_data -> unit
  (** Output a JSON value of type {!picture_data}. *)

val string_of_picture_data :
  ?len:int -> picture_data -> string
  (** Serialize a value of type {!picture_data}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_picture_data :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> picture_data
  (** Input JSON data of type {!picture_data}. *)

val picture_data_of_string :
  string -> picture_data
  (** Deserialize JSON data of type {!picture_data}. *)

val write_picture :
  Bi_outbuf.t -> picture -> unit
  (** Output a JSON value of type {!picture}. *)

val string_of_picture :
  ?len:int -> picture -> string
  (** Serialize a value of type {!picture}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_picture :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> picture
  (** Input JSON data of type {!picture}. *)

val picture_of_string :
  string -> picture
  (** Deserialize JSON data of type {!picture}. *)

val write_user :
  Bi_outbuf.t -> user -> unit
  (** Output a JSON value of type {!user}. *)

val string_of_user :
  ?len:int -> user -> string
  (** Serialize a value of type {!user}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_user :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> user
  (** Input JSON data of type {!user}. *)

val user_of_string :
  string -> user
  (** Deserialize JSON data of type {!user}. *)

val write_og_object :
  Bi_outbuf.t -> og_object -> unit
  (** Output a JSON value of type {!og_object}. *)

val string_of_og_object :
  ?len:int -> og_object -> string
  (** Serialize a value of type {!og_object}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_og_object :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> og_object
  (** Input JSON data of type {!og_object}. *)

val og_object_of_string :
  string -> og_object
  (** Deserialize JSON data of type {!og_object}. *)

