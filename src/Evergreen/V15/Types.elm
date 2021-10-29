module Evergreen.V15.Types exposing (..)

import File
import Lamdera
import RemoteData
import Set


type alias FrontendModel =
    { counter : Int
    , clientId : String
    }


type alias BackendModel =
    { counter : Int
    , clients : Set.Set Lamdera.ClientId
    , test : String
    , thirdPartyType : RemoteData.WebData String
    }


type FrontendMsg
    = Increment
    | Decrement
    | ClickedSelectFile
    | FileSelected File.File
    | FNoop


type ToBackend
    = CounterIncremented
    | CounterDecremented
    | Blah


type BackendMsg
    = ClientJoin Lamdera.SessionId Lamdera.ClientId
    | Noop


type alias BackendModel =
    { counter : Int
    , clients : Set.Set Lamdera.ClientId
    , test : String
    , thirdPartyType : RemoteData.WebData String
    }


type ToFrontend
    = CounterNewValue Int String
    | TestWire BackendModel
