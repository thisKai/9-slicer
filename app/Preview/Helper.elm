module Preview.Helper exposing (..)

import Types as Types
import Preview.Types exposing (..)


getMargin : Margins -> Side -> Int
getMargin margins name =
    case name of
        Top ->
            margins.top

        Right ->
            margins.right

        Bottom ->
            margins.bottom

        Left ->
            margins.left

        _ ->
            0


setMargin : Margins -> Side -> Int -> Margins
setMargin margins name val =
    case name of
        Top ->
            { margins | top = val }

        Right ->
            { margins | right = val }

        Bottom ->
            { margins | bottom = val }

        Left ->
            { margins | left = val }

        _ ->
            margins


sideToString : Side -> String
sideToString side =
    case side of
        None ->
            ""

        Top ->
            "top"

        Right ->
            "right"

        Bottom ->
            "bottom"

        Left ->
            "left"


sideFromString : String -> Side
sideFromString sideString =
    case sideString of
        "top" ->
            Top

        "right" ->
            Right

        "bottom" ->
            Bottom

        "left" ->
            Left

        _ ->
            None


oppositeSide : Side -> Side
oppositeSide side =
    case side of
        None ->
            None

        Top ->
            Bottom

        Right ->
            Left

        Bottom ->
            Top

        Left ->
            Right


dragMargin : Types.Size -> Margins -> Side -> Int -> Int -> Int -> Int
dragMargin size margins side startMargin startPosition currentPosition =
    let
        posDiff =
            currentPosition - startPosition

        operator =
            if side == Bottom || side == Right then
                (-)
            else
                (+)
    in
        (operator startMargin posDiff)
            |> max 0
            |> min (size.width - (side |> oppositeSide |> getMargin margins))


dragMargins : Types.Model -> Margins
dragMargins model =
    let
        currentMargins =
            model.margins

        dragData =
            model.drag
    in
        case dragData of
            Nothing ->
                currentMargins

            Just { start, current, data } ->
                let
                    getDragMargin =
                        dragMargin model.previewSize model.margins data.side
                in
                    case data.side of
                        None ->
                            currentMargins

                        Top ->
                            { currentMargins | top = getDragMargin data.startMargin.top start.y current.y }

                        Right ->
                            { currentMargins | right = getDragMargin data.startMargin.right start.x current.x }

                        Bottom ->
                            { currentMargins | bottom = getDragMargin data.startMargin.bottom start.y current.y }

                        Left ->
                            { currentMargins | left = getDragMargin data.startMargin.left start.x current.x }
