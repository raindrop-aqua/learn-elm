module Chapter3.Section21.HttpAccess exposing (main)

import Browser
import Html exposing (button, div, p, text)
import Html.Events exposing (onClick)
import Http


main : Program() Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }


-- MODEL

type alias Model =
    { result : String
    }

init : () -> (Model, Cmd Msg)
init _ =
    ( { result = "" }
    , Cmd.none
    )

-- UPDATE

type Msg
    = Click
    | GotRepo (Result Http.Error String)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Click ->
            ( model
            , Http.get
                { url = "https://api.github.com/repos/elm/core"
                , expect = Http.expectString GotRepo
                }
            )

        GotRepo (Ok repo) ->
            ( { model | result = repo}, Cmd.none )

        GotRepo (Err error) ->
            ( { model | result = Debug.toString error}, Cmd.none )

-- VIEW

view model =
    div[]
        [ button [ onClick Click ] [ text "Get Repository info" ]
        , p [][ text model.result ]
        ]