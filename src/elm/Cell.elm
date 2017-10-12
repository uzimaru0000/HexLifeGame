module Cell exposing (..)

import Color exposing (..)

type Status = Living
            | Dead

type alias Point =
    { x : Float
    , y : Float
    }

type alias Cell = 
    { status : Status
    , position : Point
    }

cellColor : Status -> Color
cellColor status =
    case status of
        Living -> lightGreen
        Dead -> darkGreen

-- poly : Int -> List Point
-- poly n =
--     let
--         angle = 2 * pi / (toFloat n)
--     in
--         List.range 0 5
--             |> List.map (\x -> Point (cos <| angle * (toFloat x)) (sin <| angle * (toFloat x)))

-- hex : Float -> Point -> List Point
-- hex size base =
--     List.map (\p -> { p | x = p.x * size, y = p.y * size }) (poly 6)
--     |> List.map (\p -> { p | x = p.x + base.x, y = p.y + base.y })