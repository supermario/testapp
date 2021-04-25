module Types exposing (..)

import Bytes exposing (Bytes)
import File exposing (File)
import Lamdera exposing (..)
import Set exposing (Set)
import Task exposing (Task)
import Time exposing (Posix)


type alias BackendModel =
    { counter : Int
    , clients : Set ClientId
    , test : String
    }


type alias FrontendModel =
    { counter : Int
    , clientId : String
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
    = ClientJoin SessionId ClientId
    | Noop


type ToFrontend
    = CounterNewValue Int String


x =
    1
