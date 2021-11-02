module Example exposing (..)

import Expect exposing (..)
import Fuzz exposing (Fuzzer, int, list, string)
import Lamdera
import Test exposing (..)


suite : Test
suite =
    test "test" <|
        \_ ->
            let
                x =
                    Lamdera.sendToBackend
            in
            equal 1 1
