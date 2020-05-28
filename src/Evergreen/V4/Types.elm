module Evergreen.V4.Types exposing (..)

import Lamdera
import Set


type alias FrontendModel =
    { counter : Int
    , clientId : String
    }


type alias BackendModel =
    { counter : Int
    , clients : (Set.Set Lamdera.ClientId)
    }


type FrontendMsg
    = Increment
    | Decrement
    | FNoop


type ToBackend
    = ClientJoin
    | CounterIncremented
    | CounterDecremented


type BackendMsg
    = Noop


type ToFrontend
    = CounterNewValue Int String