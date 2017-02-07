module Preview.View exposing (..)

import Types as Types
import Helper exposing (..)
import Preview.Types exposing (..)
import Preview.Helper exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Mouse exposing (Position)
import Json.Decode as Decode


mouseMsg : (Position -> Msg) -> Position -> Types.Msg
mouseMsg msg pos =
    Types.PreviewMessage (msg pos)


onMarginDragStart side =
    on "mousedown" (Decode.map (mouseMsg (MarginDragStart side)) Mouse.position)


marginLabel margin =
    div [ class "margin-label" ] [ text (toString margin) ]


marginsPreview margins =
    div [ class "margins-preview" ]
        [ div [ class "margin highlight margin-top", style [ ( "height", px margins.top ) ] ] []
        , div [ class "margin highlight margin-right", style [ ( "width", px margins.right ) ] ] []
        , div [ class "margin highlight margin-bottom", style [ ( "height", px margins.bottom ) ] ] []
        , div [ class "margin highlight margin-left", style [ ( "width", px margins.left ) ] ] []
        , div
            [ class "margin margin-resizer margin-resizer-top"
            , onMarginDragStart Top
            , draggable "false"
            , style
                [ ( "height", px margins.top )
                , ( "left", px margins.left )
                , ( "right", px margins.right )
                ]
            ]
            [ marginLabel margins.top ]
        , div
            [ class "margin margin-resizer margin-resizer-right"
            , onMarginDragStart Right
            , draggable "false"
            , style
                [ ( "width", px margins.right )
                , ( "top", px margins.top )
                , ( "bottom", px margins.bottom )
                ]
            ]
            [ marginLabel margins.right ]
        , div
            [ class "margin margin-resizer margin-resizer-bottom"
            , onMarginDragStart Bottom
            , draggable "false"
            , style
                [ ( "height", px margins.bottom )
                , ( "left", px margins.left )
                , ( "right", px margins.right )
                ]
            ]
            [ marginLabel margins.bottom ]
        , div
            [ class "margin margin-resizer margin-resizer-left"
            , onMarginDragStart Left
            , draggable "false"
            , style
                [ ( "width", px margins.left )
                , ( "top", px margins.top )
                , ( "bottom", px margins.bottom )
                ]
            ]
            [ marginLabel margins.left ]
        ]


changeMarginsMsg side text =
    Types.PreviewMessage (ChangeMargins side text)


marginInput margin val =
    div [ class "margin-input" ]
        [ label [] [ text (toString margin) ]
        , input
            [ type_ "number"
            , value (toString val)
            , onInput (changeMarginsMsg margin)
            ]
            []
        ]


changeMarginPreviewVisibilityMsg visibility =
    Types.PreviewMessage (ChangeMarginPreviewVisibility visibility)


marginsInput margins showPreview =
    div []
        [ h1 [] [ text "Margins" ]
        , div [ class "margins-input" ]
            [ marginInput Top margins.top
            , marginInput Right margins.right
            , marginInput Bottom margins.bottom
            , marginInput Left margins.left
            ]
        , label []
            [ input [ type_ "checkbox", checked showPreview, onCheck changeMarginPreviewVisibilityMsg ] []
            , text "Show Margins"
            ]
        ]


imageSlice9 sourceData size margins =
    let
        cssMargins =
            [ margins.top
            , margins.right
            , margins.bottom
            , margins.left
            ]
                |> List.map toString
                |> String.join " "
    in
        div
            [ style
                [ ( "width", size.width )
                , ( "height", size.height )
                , ( "flex-grow", "1" )
                , ( "box-sizing", "border-box" )
                , ( "border-style", "solid" )
                , ( "border-width", cssMargins )
                  --, ( "border-image-width", cssMargins )
                , ( "border-image-slice", cssMargins )
                , ( "border-image-source"
                  , case sourceData of
                        Nothing ->
                            ""

                        Just data ->
                            "url(" ++ data.url ++ ")"
                  )
                ]
            ]
            []


previewDisplaySize size stretch =
    if stretch then
        "auto"
    else
        px size


imageMarginsEditor model =
    let
        { previewSize, margins, showMarginsOverlay } =
            model

        { top, left, bottom, right } =
            margins
    in
        div [ class "checkerboard" ]
            [ imageSlice9 model.sourceImage
                { width = previewDisplaySize previewSize.width model.stretchPreview
                , height = previewDisplaySize previewSize.height model.stretchPreview
                }
                margins
            , if showMarginsOverlay then
                marginsPreview margins
              else
                text ""
            ]
