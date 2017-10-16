module Models exposing (..)

import Cell exposing (..)

type alias Model = List Cell

cellSize : Point
cellSize = Point 16 16

initModel : Model
initModel =
    [ Cell (Point 0 0) Dead []
    , Cell (Point 1 0) Dead []
    , Cell (Point 2 0) Dead []
    , Cell (Point 3 0) Dead []
    , Cell (Point 0 1) Dead []
    , Cell (Point 1 1) Dead []
    , Cell (Point 2 1) Dead []
    , Cell (Point 3 1) Dead []
    , Cell (Point 0 2) Dead []
    , Cell (Point 1 2) Dead []
    , Cell (Point 2 2) Dead []
    , Cell (Point 3 2) Dead []
    ]