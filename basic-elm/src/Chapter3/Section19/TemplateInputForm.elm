module Chapter3.Section19.InputForm exposing (main)


import Browser
import Html exposing (Html, text)

main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }

-- MODEL

type alias Model =
    {}
init : Model
init =
    {}

-- UPDATE

type Msg =
    Msg

update : Msg -> Model -> Model
update msg model =
    model


-- VIEW

view : Model -> Html Msg
view model =
    text ""
