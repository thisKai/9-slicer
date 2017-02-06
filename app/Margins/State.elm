module Margins.State exposing (..)

import Types as Types
import Ports exposing (..)
import Margins.Types exposing (..)
import Margins.Helper exposing (..)
import Mouse exposing (Position)

subscriptions : Types.Model -> Sub Types.Msg
subscriptions model =
    case model.drag of
        Nothing ->
            receiveUrl (\url -> (Types.ImageSlicerMessage (ChangeSource url)))

        Just drag ->
            Sub.batch
                [ Mouse.moves (\pos -> (Types.ImageSlicerMessage (MarginDragMove drag.side pos)))
                , Mouse.ups (\pos -> (Types.ImageSlicerMessage (MarginDragEnd drag.side pos)))
                ]

update : Msg -> Types.Model -> (Types.Model, Cmd Types.Msg)
update msg model =
    case msg of
        RequestOpenUrl ->
            ( model, requestOpenUrl () )

        ChangeSource url ->
            ( { model | source = Url url }, Cmd.none )

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
            ( { model | showMarginsPreview = val }, Cmd.none )

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
