module Preview.State exposing (..)

import Types as Types
import Helper exposing (..)
import Ports exposing (..)
import Preview.Types exposing (..)
import Preview.Helper exposing (..)
import Mouse exposing (Position)


subscriptions : Types.Model -> Sub Types.Msg
subscriptions model =
    case model.drag of
        Nothing ->
            Sub.none

        Just drag ->
            Sub.batch
                [ Mouse.moves (\pos -> (Types.PreviewMessage (MarginDragMove drag.side pos)))
                , Mouse.ups (\pos -> (Types.PreviewMessage (MarginDragEnd drag.side pos)))
                ]


update : Msg -> Types.Model -> ( Types.Model, Cmd Types.Msg )
update msg model =
    case msg of
        ChangeSize prop val ->
            let
                intValue =
                    case (String.toInt val) of
                        Ok v ->
                            v

                        Err _ ->
                            0
            in
                ( { model | previewSize = setSize model.previewSize prop intValue }, Cmd.none )

        ChangeStretchPreview val ->
            ( { model | stretchPreview = val }, Cmd.none )

        ChangeMargins prop val ->
            let
                intValue =
                    case (String.toInt val) of
                        Ok v ->
                            v

                        Err _ ->
                            0
            in
                ( { model | margins = setMargin model.margins prop intValue }, Cmd.none )

        ChangeMarginPreviewVisibility val ->
            ( { model | showMarginsOverlay = val }, Cmd.none )

        MarginDragStart side position ->
            ( { model
                | drag =
                    Just
                        { side = side
                        , start = position
                        , current = position
                        , startMargins = model.margins
                        }
              }
            , Cmd.none
            )

        MarginDragMove side position ->
            ( { model
                | drag =
                    case model.drag of
                        Nothing ->
                            model.drag

                        Just ddata ->
                            Just
                                { ddata
                                    | side = side
                                    , current = position
                                }
                , margins = dragMargins model
              }
            , Cmd.none
            )

        MarginDragEnd side position ->
            ( { model
                | drag = Nothing
              }
            , Cmd.none
            )

        _ ->
            ( model, Cmd.none )
