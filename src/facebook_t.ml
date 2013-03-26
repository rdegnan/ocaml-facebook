(* Auto-generated from "facebook.atd" *)


type api_error = { message: string; kind: string; code: int }

type error = { error: api_error }

type graph_object = { id: string; name: string option }

type picture_data = { url: string; is_silhouette: bool }

type picture = { data: picture_data }

type cover = {
  cover_id: string;
  source: string option;
  offset_y: int option
}

type like = {
  like_id (*atd id *): string;
  like_name (*atd name *): string option;
  like_description (*atd description *): string option;
  like_category (*atd category *): string option;
  like_link (*atd link *): string option;
  like_website (*atd website *): string option;
  like_talking_about_count (*atd talking_about_count *): int option;
  like_likes (*atd likes *): int option;
  like_created_time (*atd created_time *): string option;
  like_cover (*atd cover *): cover option;
  like_can_post (*atd can_post *): bool option
}

type like_data = { liked_data (*atd data *): like list }

type friend_data = { friend_data (*atd data *): graph_object list }

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
