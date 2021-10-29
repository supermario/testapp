module Backend exposing (app, init)

import Lamdera exposing (ClientId, SessionId, sendToFrontend)
import RemoteData
import Set exposing (Set)
import Types exposing (..)


type alias Model =
    BackendModel


app =
    Lamdera.backend
        { init = init
        , update = update
        , updateFromFrontend = updateFromFrontend
        , subscriptions = \m -> Lamdera.onConnect ClientJoin
        }


init : ( Model, Cmd BackendMsg )
init =
    ( { counter = 0
      , clients = Set.empty
      , test = ""
      , thirdPartyType = RemoteData.NotAsked
      }
    , Cmd.none
    )


update : BackendMsg -> Model -> ( Model, Cmd BackendMsg )
update msg model =
    case msg of
        ClientJoin sessionId clientId ->
            ( { model | clients = Set.insert clientId model.clients }
            , Cmd.batch
                [ sendToFrontend clientId (CounterNewValue model.counter sessionId)
                , sendToFrontend clientId (TestWire model)
                ]
            )

        Noop ->
            ( model, Cmd.none )


updateFromFrontend : SessionId -> ClientId -> ToBackend -> Model -> ( Model, Cmd BackendMsg )
updateFromFrontend sessionId clientId msg model =
    case msg of
        CounterIncremented ->
            let
                newCounterValue =
                    model.counter + 1
            in
            ( { model | counter = newCounterValue }, broadcast model.clients (CounterNewValue newCounterValue clientId) )

        CounterDecremented ->
            let
                newCounterValue =
                    model.counter - 1
            in
            ( { model | counter = newCounterValue }, broadcast model.clients (CounterNewValue newCounterValue clientId) )

        Blah ->
            ( model, Cmd.none )


broadcast clients msg =
    clients
        |> Set.toList
        |> List.map (\clientId -> sendToFrontend clientId msg)
        |> Cmd.batch
