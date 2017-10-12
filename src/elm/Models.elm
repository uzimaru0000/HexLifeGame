module Models exposing (..)

import Cell exposing (..)

type alias Model = List Cell

initModel : Model
initModel = [ Cell Living (Point 0 0) 32
            , Cell Living (Point 33 0) 32
            ] 