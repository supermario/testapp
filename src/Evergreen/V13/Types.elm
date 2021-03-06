module Evergreen.V13.Types exposing (..)

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
    | FileSelected File.File
    | FNoop


type ToBackend
    = ClientJoin
    | CounterIncremented
    | CounterDecremented
    | Blah


type BackendMsg
    = Noop


type ToFrontend
    = CounterNewValue Int String
