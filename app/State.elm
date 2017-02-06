module State exposing (..)

import Ports exposing (..)
import Types exposing (..)
import Helper exposing (..)
import Preview.Types as Preview
import Preview.Helper exposing (..)
import Preview.State
import Mouse exposing (Position)


init : ( Model, Cmd msg )
init =
    ( { source = Preview.Url "example.png"
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
    Preview.State.subscriptions model



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        RequestOpenUrl ->
            ( model, requestOpenUrl () )

        ChangeImageSource url ->
            ( { model | source = Preview.Url url }, Cmd.none )

        PreviewMessage imageSlicerMsg ->
            Preview.State.update imageSlicerMsg model
