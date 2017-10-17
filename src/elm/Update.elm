module Update exposing (..)

import Cell exposing (..)
import Random exposing (..)
import Models exposing (..)
import Messages exposing (..)

rule : Int -> Status -> Status
rule count state =
    if state == Living then
        case count of
            2 -> Living
            3 -> Living
            _ -> Dead
    else
        case count of
            3 -> Living
            4 -> Living
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
        NewGame cells -> Model cells False ! []
        Start -> model ! []
        NextTick ->
            Model (List.map (\cell -> 
                        let
                            nowState = cell.status
                            nextState = collectCell model.cells cell.adjacency
                                        |> List.map (\x -> x.status)
                                        |> countState
                                        |> flip rule nowState
                        in
                            { cell | status = nextState }
                     ) model.cells) model.gameStatus
            |> flip (!) []
        Stop -> { model | gameStatus = not model.gameStatus} ! []
        Flip cell -> 
            let
                newCell = List.map (\x -> if x == cell then {x | status = flipStatus cell.status} else x) model.cells
            in
                Model newCell model.gameStatus ! []
        Reset ->
            (Model [] False, Random.generate NewGame (newCells cellSize))
        Clear ->
            let
                newCells = List.map (\x -> {x | status = Dead }) model.cells
            in
                Model newCells False ! []