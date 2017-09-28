port module Codegen exposing (..)

port codegenready : (() -> msg) -> Sub msg

port codegenrequest : String -> Cmd msg

port codegenresult : (String -> msg) -> Sub msg
