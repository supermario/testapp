module Frontend exposing (Model, app)

import Env
import File.Select
import Html exposing (Html, text)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Http
import Lamdera exposing (sendToBackend)
import Task
import Types exposing (..)


version =
    "12"


type alias Model =
    FrontendModel


{-| Lamdera applications define 'app' instead of 'main'.

Lamdera.frontend is the same as Browser.application with the
additional update function; updateFromBackend.

-}
app =
    Lamdera.frontend
        { init = \_ _ -> init
        , update = update
        , updateFromBackend = updateFromBackend
        , view =
            \model ->
                { title = "v1"
                , body = [ view model ]
                }
        , subscriptions = \_ -> Sub.none
        , onUrlChange = \_ -> FNoop
        , onUrlRequest = \_ -> FNoop
        }


init : ( Model, Cmd FrontendMsg )
init =
    ( { counter = 0, clientId = "" }, Cmd.none )


update : FrontendMsg -> Model -> ( Model, Cmd FrontendMsg )
update msg model =
    case msg of
        Increment ->
            ( { model | counter = model.counter + 1 }, sendToBackend CounterIncremented )

        Decrement ->
            ( { model | counter = model.counter - 1 }, sendToBackend CounterDecremented )

        ClickedSelectFile ->
            ( model, File.Select.file [ "*" ] FileSelected )

        FileSelected file ->
            ( model, Cmd.none )

        FNoop ->
            ( model, Cmd.none )


updateFromBackend : ToFrontend -> Model -> ( Model, Cmd FrontendMsg )
updateFromBackend msg model =
    case msg of
        CounterNewValue newValue sessionId ->
            ( { model | counter = newValue, clientId = sessionId }, Cmd.none )

        TestWire _ ->
            ( model, Cmd.none )


view : Model -> Html FrontendMsg
view model =
    Html.div [ style "padding" "30px" ]
        [ Html.button [ onClick Increment ] [ text "+" ]
        , Html.text (String.fromInt model.counter)
        , Html.button [ onClick Decrement ] [ text "-" ]
        , Html.div [] [ Html.text "Click me then refresh me!" ]
        , d <| Html.text model.clientId
        , d <| Html.text Env.dummyConfigItem
        , d <|
            Html.text <|
                case Env.mode of
                    Env.Production ->
                        "Prod"

                    Env.Development ->
                        "Development"
        , d <| Html.text version
        , d <| Html.button [ onClick ClickedSelectFile ] [ text "Select file!" ]
        ]


d x =
    Html.div [] [ x ]
