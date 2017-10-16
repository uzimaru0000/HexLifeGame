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

poly : Int -> List Vector
poly n =
    let
        angle = 2 * pi / (toFloat n)
    in
        List.range 0 (n-1)
            |> List.map (\x -> Vector (cos <| angle * (toFloat x) - pi / 2) (sin <| angle * (toFloat x) - pi / 2))

hex : Float -> Vector -> List Vector
hex size base =
    List.map (\p -> { p | x = p.x * size, y = p.y * size }) (poly 6)
    |> List.map (\p -> { p | x = p.x + base.x, y = p.y + base.y })

hexWidth : Float -> Float
hexWidth radius =
    radius * (cos <| pi / 6)

hexEdge : Float -> Float
hexEdge radius =
    2 * radius * (sin <| pi / 6)

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
        w = hexWidth 32
        edge = hexEdge 32
    in
        svg [ width <| toString screenSize.x, height <| toString screenSize.y, viewBox <| "0 0 " ++ (pointToString screenSize) ]
        <| List.map (\cell ->
            let
                offs = (toFloat <| cell.id.y % 2) / 2
                x = (toFloat cell.id.x + offs) * w * 2
                y = (toFloat cell.id.y) * (edge / 2 + 32)
                vert = hex 32 (Vector x y)
                       |> List.map vectorToString
                       |> String.join " "
            in
                polygon [ points vert
                        , fill <| colorToString <| cellColor cell.status
                        , stroke <| colorToString <| Color.black
                        ] []
        ) model