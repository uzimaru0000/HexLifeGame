module Main exposing (..)

import Html exposing (Html, program)
import Color exposing (..)
import Models exposing (..)
import Cell exposing (cellColor)
import Svg exposing (..)
import Svg.Attributes exposing (..)

init : ( Model, Cmd Msg )
init =
    ( initModel, Cmd.none )

type Msg = NoOp

colorToString : Color -> String
colorToString color =
    let
        rgb = toRgb color
        r = rgb.red
        g = rgb.green
        b = rgb.blue
    in
        "rgb(" ++
        toString r ++ "," ++
        toString g ++ "," ++
        toString b ++ ")"

view : Model -> Html Msg
view model =
    svg [ width "320", height "320", viewBox "0 0 320 320" ]
    <| List.map (\cell ->
        rect [ x <| toString cell.position.x
             , y <| toString cell.position.y
             , fill <| colorToString <| cellColor cell.status
             , stroke <| colorToString <| Color.black
             , width <| "16"
             , height <| "16"
             ] []
    ) model

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