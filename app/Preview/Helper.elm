module Preview.Helper exposing (..)

import Helper exposing (..)
import Preview.Types exposing (..)


sourceToCSS src =
    case src of
        Nowhere ->
            ""

        Url url ->
            "url(" ++ (fixWindowsUrl url) ++ ")"


setSize : Size -> String -> Int -> Size
setSize size name val =
    case name of
        "width" ->
            { size | width = val }

        "height" ->
            { size | height = val }

        _ ->
            size


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


dragMargin : Size -> Margins -> Side -> Int -> Int -> Int -> Int
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

            Just { side, start, current, startMargins } ->
                let
                    getDragMargin =
                        dragMargin model.previewSize model.margins side
                in
                    case side of
                        None ->
                            currentMargins

                        Top ->
                            { currentMargins | top = getDragMargin startMargins.top start.y current.y }

                        Right ->
                            { currentMargins | right = getDragMargin startMargins.right start.x current.x }

                        Bottom ->
                            { currentMargins | bottom = getDragMargin startMargins.bottom start.y current.y }

                        Left ->
                            { currentMargins | left = getDragMargin startMargins.left start.x current.x }
