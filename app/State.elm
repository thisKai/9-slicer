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
    ( { source = Url "example.png"
      , size =
            { width = 216
            , height = 216
            }
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
            case model.source of
                Nowhere ->
                    ( model, Cmd.none )

                Url src ->
                    ( model
                    , saveSlices
                        { imageUrl = src
                        , dimensions = (getCropDimensions model.size model.margins)
                        }
                    )

        OpenImage imageData ->
            ( { model
                | source =
                    case imageData.sourceUrl of
                        Nothing ->
                            Nowhere

                        Just url ->
                            Url url
                , size = imageData.size
              }
            , Cmd.none
            )

        PreviewMessage imageSlicerMsg ->
            Preview.State.update imageSlicerMsg model
