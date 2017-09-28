module App exposing (..)

import Codegen exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import LocalStorage


type alias Model =
    { input : String
    , output : String
    , ready : Bool
    }


type alias Flags =
    { stored : Maybe String
    }


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( { input =
            case flags.stored of
                Just value ->
                    value

                Nothing ->
                    "json_typegen!(\"Foo\", \"{}\");"
      , output = ""
      , ready = False
      }
    , Cmd.none
    )


subs : Model -> Sub Msg
subs model =
    Sub.batch
        [ codegenresult CodegenResult
        , codegenready (\() -> CodegenReady)
        ]


type Msg
    = CodegenReady
    | CodegenRequest String
    | CodegenResult String
    | InputChange String


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        CodegenReady ->
            ( { model | ready = True }, codegenrequest model.input )

        CodegenRequest input ->
            ( model, codegenrequest input )

        CodegenResult code ->
            ( { model | output = code }, Cmd.none )

        InputChange newInput ->
            ( { model | input = newInput }
            , Cmd.batch
                [ codegenrequest newInput, LocalStorage.store newInput ]
            )


view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ h1 []
            [ text "json_typegen - Rust types from JSON samples"
            ]
        , textarea [ cols 40, rows 10, placeholder "...", onInput InputChange ] [ text model.input ]
        , div [ class "buttons"]
            [ button
                [ class "btn btn-primary"
                , disabled (not model.ready)
                , onClick (CodegenRequest model.input)
                ]
                [ text "Generate" ]
            ]
        , div [] [ pre [] [ code [] [ text model.output ] ] ]

        -- , p [] [text <| toString model]
        ]
