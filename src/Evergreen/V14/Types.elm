module Evergreen.V14.Types exposing (..)

import File
import Lamdera
import Set


type alias FrontendModel =
    { counter : Int
    , clientId : String
    }


type alias BackendModel =
    { counter : Int
    , clients : Set.Set Lamdera.ClientId
    , test : String
    }


type FrontendMsg
    = Increment
    | Decrement
    | ClickedSelectFile
    | FileSelected File
    | FNoop


type ToBackend
    = CounterIncremented
    | CounterDecremented
    | Blah


type BackendMsg
    = ClientJoin Lamdera.SessionId Lamdera.ClientId
    | Noop


type ToFrontend
    = CounterNewValue Int String
