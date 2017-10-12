module Cell exposing (..)

type Status = Living
            | Dead

type alias Point =
    { x : Float
    , y : Float
    }

type alias Cell = 
    { status : Status
    , position : Point
    , size : Float
    }