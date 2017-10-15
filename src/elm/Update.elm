module Update exposing (..)

import Cell exposing (..)
import Models exposing (..)
import Messages exposing (..)

rule : Int -> Status -> Status
rule count state =
    case (count, state) of
        (3, Dead) -> Living
        (_, Dead) -> Dead
        (2, Living) -> Living
        (3, Living) -> Living
        -- (4, Living) -> Living
        -- (5, Living) -> Living
        (_, Living) -> Dead

countState : List Status -> Int
countState list =
    List.filter (\s -> s == Living) list
    |> List.length

collectCell : List Cell -> List Point -> List Cell
collectCell cells adjacency =
    List.filter (\cell -> List.any (\id -> cell.id == id) adjacency) cells

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NewGame cells -> cells ! []
        Start -> model ! []
        NextTick ->
            List.map (\cell -> 
                        let
                            nowState = cell.status
                            nextState = collectCell model cell.adjacency
                                        |> List.map (\x -> x.status)
                                        |> countState
                                        |> flip rule nowState
                        in
                            { cell | status = nextState }
                     ) model
            |> flip (!) []