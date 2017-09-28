module Main exposing (main)

import Html
import App exposing (init, update, view, subs)


main =
    Html.programWithFlags
        { init = init
        , update = update
        , view = view
        , subscriptions = subs
        }
