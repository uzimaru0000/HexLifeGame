module Cell exposing (..)

import Color exposing (..)
import Random exposing (..)

type Status = Living
            | Dead

type alias Point =
    { x : Int
    , y : Int
    }

type alias Vector =
    { x : Float
    , y : Float
    }

type alias Cell =
    { id : Point
    , status : Status
    , adjacency : List Point
    }

cellSize : Point
cellSize = Point 16 16

cellColor : Status -> Color
cellColor status =
    case status of
        Living -> lightGreen
        Dead -> darkGreen

pointToString : Point -> String
pointToString p = 
    toString p.x ++ " " ++ toString p.y

vectorToString : Vector -> String
vectorToString v =
    toString v.x ++ " " ++ toString v.y

newState : Int -> Random.Generator (List Status)
newState length =
    Random.float 0.0 1.0
    |> Random.map (\n -> if n >= 0.8 then Living else Dead)
    |> Random.list length

newCells : Point -> Random.Generator (List Cell)
newCells size =
    newState (size.x * size.y)
    |> Random.map (\xs -> List.indexedMap (,) xs)
    |> Random.map (\xs -> List.map (newCell size) xs)

newCell : Point -> (Int, Status) -> Cell
newCell size (index, state) =
    let
        id = Point (index % size.x) (index // size.y)
    in
        normalCellConnect id
        |> Cell id state

connectCell : Point -> List Point
connectCell id = 
    [ Point (id.x-1) (id.y-1)
    , Point id.x (id.y-1)
    , Point (id.x-1) id.y
    , Point (id.x+1) id.y
    , Point (id.x-1) (id.y+1)
    , Point id.x (id.y+1)
    ] |> List.filter (\p -> p.x >= 0 || p.y >= 0)

normalCellConnect : Point -> List Point
normalCellConnect id =
    [ Point (id.x-1) (id.y-1)
    , Point id.x (id.y-1)
    , Point (id.x+1) (id.y-1)
    , Point (id.x-1) id.y
    , Point (id.x+1) id.y
    , Point (id.x-1) (id.y+1)
    , Point id.x (id.y+1)
    , Point (id.x+1) (id.y+1)
    ] |> List.filter (\p -> (p.x >= 0 && p.x < cellSize.x) || (p.y >= 0 && p.y < cellSize.y))