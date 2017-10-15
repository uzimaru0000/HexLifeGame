module Models exposing (..)

import Cell exposing (..)

type alias Model = List Cell

cellSize : Point
cellSize = Point 16 16