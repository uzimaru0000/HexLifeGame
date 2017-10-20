module Main exposing (..)

import Html exposing (Html, program)
import Random exposing (..)
import Time exposing (..)
import View exposing (..)
import Models exposing (..)
import Update exposing (..)
import Cell exposing (newCells, cellSize)
import Messages exposing (..)

init : ( Model, Cmd Msg )
init =
    ( Model [] False "normal",  Random.generate NewGame (newCells cellSize))
    -- initModel ! []

subscriptions : Model -> Sub Msg
subscriptions model = 
    if model.gameStatus then
        Time.every (Time.millisecond * 40) (always NextTick)
    else
        Sub.none

main : Program Never Model Msg
main = 
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }