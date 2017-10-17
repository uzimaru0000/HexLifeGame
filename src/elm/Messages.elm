module Messages exposing (..)

import Cell exposing (..)

type Msg = NewGame (List Cell)
         | Start
         | NextTick
         | Stop
         | Flip Cell
         | Reset
         | Clear