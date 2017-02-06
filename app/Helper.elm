module Helper exposing (..)

import Types exposing (..)
import Preview.Types as Preview
import Char
import String
import Regex exposing (..)


utf code =
    code |> Char.fromCode |> String.fromChar


px val =
    (toString val) ++ "px"


fixWindowsUrl =
    Regex.replace All (regex "\\\\") (\_ -> "/")


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


getCropDimensions : Size -> Preview.Margins -> CropDimensions
getCropDimensions size margins =
    let
        centerRight =
            size.width - margins.right

        centerBottom =
            size.height - margins.bottom

        topLeftCorner =
            { left = 0
            , top = 0
            , right = margins.left
            , bottom = margins.top
            }

        topEdge =
            { left = margins.left
            , top = 0
            , right = centerRight
            , bottom = margins.top
            }

        topRightCorner =
            { left = centerRight
            , top = 0
            , right = size.width
            , bottom = margins.top
            }

        rightEdge =
            { left = centerRight
            , top = margins.top
            , right = size.width
            , bottom = centerBottom
            }

        bottomRightCorner =
            { left = centerRight
            , top = centerBottom
            , right = size.width
            , bottom = size.height
            }

        bottomEdge =
            { left = margins.left
            , top = centerBottom
            , right = centerRight
            , bottom = size.height
            }

        bottomLeftCorner =
            { left = 0
            , top = centerBottom
            , right = margins.left
            , bottom = size.height
            }

        leftEdge =
            { left = 0
            , top = margins.top
            , right = margins.left
            , bottom = centerBottom
            }
    in
        { topLeftCorner = topLeftCorner
        , topEdge = topEdge
        , topRightCorner = topRightCorner
        , rightEdge = rightEdge
        , bottomRightCorner = bottomRightCorner
        , bottomEdge = bottomEdge
        , bottomLeftCorner = bottomLeftCorner
        , leftEdge = leftEdge
        }
