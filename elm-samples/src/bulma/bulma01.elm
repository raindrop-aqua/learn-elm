
import Browser
import Bulma.CDN exposing (stylesheet)
import Bulma.Columns exposing (column, columnModifiers, columns, columnsModifiers)
import Bulma.Modifiers exposing (Color(..), Size(..))
import Bulma.Elements exposing (TitleSize(..), title)
import Bulma.Layout exposing (SectionSpacing(..), container, hero, heroBody, heroModifiers, section)
import Html exposing (Html, main_, text)

type alias Model = {}
type Msg = NoOp

main : Program () Model Msg
main
    = Browser.sandbox
        { init = {}
        , view = view
        , update = \msg -> \model -> model

        }

view : Model -> Html msg
view model
    = main_ []
    [ stylesheet
    , exampleHero
    , exampleColumns
    ]

exampleHero : Html msg
exampleHero
    = hero { heroModifiers | size = Medium, color = Primary } []
        [ heroBody []
            [ container []
                [ title H1 [] [ text "Hero Title" ]
                , title H2 [] [ text "Hero Subtitle" ]
                ]
            ]
        ]

exampleColumns : Html msg
exampleColumns
    = section NotSpaced []
        [ container []
            [ columns columnsModifiers []
                [ column columnModifiers [] [ text "First Column" ]
                , column columnModifiers [] [ text "Second Column" ]
                ]
            ]
        ]