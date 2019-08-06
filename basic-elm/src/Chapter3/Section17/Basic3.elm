module Main exposing (content, header, linkItem, main)

import Html exposing (Html, a, div, h1, li, text, ul)
import Html.Attributes exposing (href)


main : Html msg
main =
    div [] [ header, content ]


header : Html msg
header =
    h1 [] [ text "Useful Links" ]


content : Html msg
content =
    ul []
        [ linkItem "https://elm-lang.org" "Homepage"
        , linkItem "https://package.elm-lang.org" "Packages"
        , li [] [ a [ href "https://ellie-app.com" ] [ text "Playground" ] ]
        ]


linkItem : String -> String -> Html msg
linkItem url text_ =
    li [] [ a [ href url ] [ text text_ ] ]
