module Update exposing (..)

import Cell exposing (..)
import Random exposing (..)
import Models exposing (..)
import Messages exposing (..)

normalRule : Int -> Status -> Status
normalRule count state =
    if state == Living then
        case count of
            2 -> Living
            3 -> Living
            _ -> Dead
    else
        case count of
            3 -> Living
            _ -> Dead

hexRule : Int -> Status -> Status
hexRule count state =
    if state == Living then
        case count of
            3 -> Living
            _ -> Dead
    else
        case count of
            3 -> Living
            _ -> Dead

countState : List Status -> Int
countState list =
    List.filter (\s -> s == Living) list
    |> List.length

collectCell : List Cell -> List Point -> List Cell
collectCell cells adjacency =
    List.filter (\cell -> List.any (\id -> cell.id == id) adjacency) cells

flipStatus : Status -> Status
flipStatus status =
    case status of
        Living -> Dead
        Dead -> Living

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NewGame cells -> { model | cells = cells } ! []
        Start -> model ! []
        NextTick ->
            let
                newCells = (List.map (\cell -> 
                                        let
                                            nowState = cell.status
                                            nextState = collectCell model.cells cell.adjacency
                                            |> List.map (\x -> x.status)
                                            |> countState
                                            |> flip (if model.gameMode == "Normal" then normalRule else hexRule) nowState
                                        in
                                            { cell | status = nextState }
                                     ) model.cells) 
            in
                { model | cells = newCells } ! [] 
        Stop -> { model | gameStatus = not model.gameStatus} ! []
        Flip cell -> 
            let
                newCells = List.map (\x -> if x == cell then {x | status = flipStatus cell.status} else x) model.cells
            in
                { model | cells = newCells} ! []
        Reset ->
            (Model [] False model.gameMode, Random.generate NewGame (newCells cellSize))
        Clear ->
            let
                newCells = List.map (\x -> {x | status = Dead }) model.cells
            in
                { model | cells = newCells } ! []
        GameMode mode ->
            { model | gameMode = mode} ! []