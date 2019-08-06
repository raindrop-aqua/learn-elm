module Chapter3.Section19.InputForm exposing (main)

import Browser
import Html exposing (Html, button, div, form, input, li, text, ul)
import Html.Attributes exposing (disabled, value)
import Html.Events exposing (onInput, onSubmit)


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }



-- MODEL


type alias Model =
    { input : String
    , memos : List String
    }


init : Model
init =
    { input = ""
    , memos = []
    }



-- UPDATE


type Msg
    = Input String
    | Submit


update : Msg -> Model -> Model
update msg model =
    case msg of
        Input inputString ->
            -- 入力文字列を更新する
            { model
                | input = inputString
            }

        Submit ->
            { model
              -- 入力文字列をクリアする
                | input = ""

                -- 最新のメモを追加する
                , memos = model.input :: model.memos
            }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ form [ onSubmit Submit ]
            [ input [ value model.input, onInput Input ] []
            , button
                [ disabled (String.isEmpty (String.trim model.input)) ]
                [ text "Submit" ]
            , ul [] (List.map viewMemo model.memos)
            ]
        ]


viewMemo : String -> Html msg
viewMemo memo =
    li [] [ text memo ]
