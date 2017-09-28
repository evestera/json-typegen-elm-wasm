port module LocalStorage exposing (..)

port store : String -> Cmd msg

port restore : (String -> msg) -> Sub msg
