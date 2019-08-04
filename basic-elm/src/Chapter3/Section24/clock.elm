import Browser
import Html exposing (Html, h1, text)
import Task
import Time

-- MAIN

main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }

-- MODEL

type alias Model =
    -- タイムゾーン
    { zone : Time.Zone
    -- 現在時刻
    , time : Time.Posix
    }

init : () -> (Model, Cmd Msg)
init _ =
    -- タイムゾーンの初期値をUTCにする
    ( Model Time.utc (Time.millisToPosix 0)
    -- 実行環境のタイムゾーンを取得する
    , Task.perform AdjustTimeZone Time.here
    )

-- UPDATE

type Msg
    = Tick Time.Posix
    | AdjustTimeZone Time.Zone

update msg model =
    case msg of
       Tick newTime ->
            ( { model | time = newTime }
            , Cmd.none
            )

       AdjustTimeZone newZone ->
           ( { model | zone = newZone }
           , Cmd.none
           )

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
    -- 1秒おきにTickメッセージを受け取るようにする
    Time.every 1000 Tick

-- VIEW

view : Model -> Html Msg
view model =
    let
        hour =
            String.fromInt(Time.toHour model.zone model.time)

        minute =
            String.fromInt(Time.toMinute model.zone model.time)

        second =
            String.fromInt(Time.toSecond model.zone model.time)
    in
    h1 [] [ text (hour ++ ":" ++ minute ++ ":" ++ second) ]
