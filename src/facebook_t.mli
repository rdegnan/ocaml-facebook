(* Auto-generated from "facebook.atd" *)


type api_error = { message: string; kind: string; code: int }

type error = { error: api_error }

type graph_object = { id: string; name: string }

type picture_data = { url: string; is_silhouette: bool }

type picture = { data: picture_data }

type user = {
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

type og_object = {
  og_id (*atd id *): string;
  og_photos (*atd photos *): string list
}
