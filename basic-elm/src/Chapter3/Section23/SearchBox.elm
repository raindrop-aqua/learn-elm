module Chapter3.Section23.SearchBox exposing (main)

import Browser
import Html exposing (a, button, div, img, input, text)
import Html.Attributes exposing (autofocus, disabled, href, placeholder, src, target, value, width)
import Html.Events exposing (onInput, onSubmit)
import Http
import Json.Decode as D


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }



-- MODEL


type alias Model =
    { input : String
    , userState : UserState
    }


type UserState
    = Init
    | Waiting
    | Loaded User
    | Failed Http.Error


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model "" Init
    , Cmd.none
    )



-- UPDATE


type Msg
    = Input String
    | Send
    | Receive (Result Http.Error User)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Input newInput ->
            ( { model | input = newInput }, Cmd.none )

        Send ->
            ( { model
                | input = ""
                , userState = Waiting
              }
            , Http.get
                { url = "http://api.github.com/users/" ++ model.input
                , expect = Http.expectJson Receive userDecoder
                }
            )

        Receive (Ok user) ->
            ( { model | userState = Loaded user }, Cmd.none )

        Receive (Err e) ->
            ( { model | userState = Failed e }, Cmd.none )



-- VIEW


view model =
    div []
        [ Html.form [ onSubmit Send ]
            [ input
                [ onInput Input
                , autofocus True
                , placeholder "GitHub.com"
                , value model.input
                ]
                []
            , button
                [ disabled
                    ((model.userState == Waiting)
                        || String.isEmpty (String.trim model.input)
                    )
                ]
                [ text "Submit" ]
            ]
        , case model.userState of
            Init ->
                text ""

            Waiting ->
                text "Waiting..."

            Loaded user ->
                a
                    [ href user.htmlUrl
                    , target "_blank"
                    ]
                    [ img [ src user.avatarUrl, width 200 ] []
                    , div [] [ text user.name ]
                    , div []
                        [ case user.bio of
                            Just bio ->
                                text bio

                            Nothing ->
                                text ""
                        ]
                    ]

            Failed error ->
                div [] [ text (Debug.toString error) ]
        ]



-- DATA


type alias User =
    { login : String
    , avatarUrl : String
    , name : String
    , htmlUrl : String
    , bio : Maybe String
    }


userDecoder =
    D.map5 User
        (D.field "login" D.string)
        (D.field "avatar_url" D.string)
        (D.field "name" D.string)
        (D.field "html_url" D.string)
        (D.maybe (D.field "bio" D.string))
