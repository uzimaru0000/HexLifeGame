module Main exposing (..)

import Html exposing (Html, program)
import Svg exposing (..)
import Svg.Attributes exposing (..)

type alias Model = 
    { x : Int
    , y : Int
    }

init : ( Model, Cmd Msg )
init =
    ( { x = 100, y = 100 }, Cmd.none )

type Msg = NoOp

view : Model -> Html Msg
view model =
    svg [ width "320", height "320", viewBox "0 0 320 320" ]
        [ 
            rect [ x <| toString model.x 
                 , y <| toString model.y 
                 , width "32"
                 , height "32"
                 ] []
        ]

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp -> ( model, Cmd.none )

subscriptions : Model -> Sub Msg
subscriptions model = Sub.none

main : Program Never Model Msg
main = 
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }