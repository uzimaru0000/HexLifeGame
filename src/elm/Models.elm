module Models exposing (..)

import Cell exposing (..)

type alias Model = List Cell

initModel : Model
initModel = [ Cell Living (Point 0 0)
            , Cell Living (Point 16 0)
            , Cell Living (Point 32 0)
            ]