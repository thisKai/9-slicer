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
    ( { sourceImage = Nothing
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
    Sub.batch
        [ openImage Types.OpenImage
        , Preview.State.subscriptions model
        ]



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        RequestOpenUrl ->
            ( model, requestOpenUrl () )

        RequestSaveSlices ->
            case model.sourceImage of
                Nothing ->
                    ( model, Cmd.none )

                Just imageData ->
                    ( model
                    , saveSlices
                        { imageUrl = imageData.url
                        , dimensions = (getCropDimensions imageData.size model.margins)
                        }
                    )

        OpenImage imageData ->
            ( { model | sourceImage = Just imageData }, Cmd.none )

        PreviewMessage imageSlicerMsg ->
            Preview.State.update imageSlicerMsg model
