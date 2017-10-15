module View exposing (..)

import Html exposing (Html)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Color exposing (..)
import Cell exposing (..)
import Models exposing (..)
import Messages exposing (..)

screenSize : Point
screenSize = Point 640 640

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
    let
        w = screenSize.x // cellSize.x
        h = screenSize.y // cellSize.y
    in
        svg [ width <| toString screenSize.x, height <| toString screenSize.y, viewBox <| "0 0 " ++ (pointToString screenSize) ]
        <| List.map (\cell ->
            rect [ x <| toString <| cell.id.x * w
                , y <| toString <| cell.id.y * h
                , fill <| colorToString <| cellColor cell.status
                -- , stroke <| colorToString <| Color.black
                , width <| toString w
                , height <| toString h
                ] []
        ) model