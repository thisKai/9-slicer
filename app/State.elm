module State exposing (..)

import Ports exposing (..)
import Types exposing (..)
import Helper exposing (..)
import Margins.Types as Margins
import Margins.Helper exposing (..)
import Margins.State
import Mouse exposing (Position)


init : ( Model, Cmd msg )
init =
    ( { source = Margins.Url "example.png"
      , previewSize =
            { width = 360
            , height = 360
            }
      , stretchPreview = False
      , margins =
            { top = 64
            , right = 64
            , bottom = 64
            , left = 64
            }
      , showMarginsPreview = True
      , drag = Nothing
      }
    , Cmd.none
    )


subscriptions : Model -> Sub Msg
subscriptions model =
    Margins.State.subscriptions model



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        ImageSlicerMessage imageSlicerMsg ->
            Margins.State.update imageSlicerMsg model
