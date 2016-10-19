module Main exposing (..)

import Html exposing (..)
import Html.App as Html


main : Program Never
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { foos : List Foo }

type alias Foo = String


initialModel : Model
initialModel =
    { foos = ["foo", "bar", "baz"] }


init : ( Model, Cmd Msg )
init =
    update (ProcessFoos initialModel.foos) initialModel



-- UPDATE


type Msg
    = NoOp
    | ProcessFoos (List Foo)
    | ProcessFoo Foo


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case Debug.log "m" msg of
        NoOp ->
            ( model, Cmd.none )

        ProcessFoos foos ->
            case foos of
                [] ->
                    let _ = Debug.log "done" () in
                    ( model, Cmd.none )

                h :: t ->
                    let
                        ( processedFoo, _ ) = update (ProcessFoo h) model
                    in
                        update (ProcessFoos t) model

        ProcessFoo foo ->
            ( model, Cmd.none )


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div [] [ text (toString model) ]
