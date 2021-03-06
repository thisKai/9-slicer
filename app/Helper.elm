module Helper exposing (..)

import Types exposing (..)
import Preview.Types as Preview
import Char
import String
import Regex exposing (..)


utf : Char.KeyCode -> String
utf code =
    code |> Char.fromCode |> String.fromChar


px : a -> String
px val =
    (toString val) ++ "px"


fixWindowsUrl : String -> String
fixWindowsUrl =
    Regex.replace All (regex "\\\\") (\_ -> "/")


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

        centerWidth =
            size.width - margins.left - margins.right

        centerHeight =
            size.height - margins.top - margins.bottom

        topLeftCorner =
            { left = 0
            , top = 0
            , right = margins.left
            , bottom = margins.top
            , width = margins.left
            , height = margins.top
            }

        topEdge =
            { left = margins.left
            , top = 0
            , right = centerRight
            , bottom = margins.top
            , width = centerWidth
            , height = margins.top
            }

        topRightCorner =
            { left = centerRight
            , top = 0
            , right = size.width
            , bottom = margins.top
            , width = margins.right
            , height = margins.top
            }

        rightEdge =
            { left = centerRight
            , top = margins.top
            , right = size.width
            , bottom = centerBottom
            , width = margins.right
            , height = centerHeight
            }

        bottomRightCorner =
            { left = centerRight
            , top = centerBottom
            , right = size.width
            , bottom = size.height
            , width = margins.right
            , height = margins.bottom
            }

        bottomEdge =
            { left = margins.left
            , top = centerBottom
            , right = centerRight
            , bottom = size.height
            , width = centerWidth
            , height = margins.bottom
            }

        bottomLeftCorner =
            { left = 0
            , top = centerBottom
            , right = margins.left
            , bottom = size.height
            , width = margins.left
            , height = margins.bottom
            }

        leftEdge =
            { left = 0
            , top = margins.top
            , right = margins.left
            , bottom = centerBottom
            , width = margins.left
            , height = centerHeight
            }
    in
        { topLeft = topLeftCorner
        , top = topEdge
        , topRight = topRightCorner
        , right = rightEdge
        , bottomRight = bottomRightCorner
        , bottom = bottomEdge
        , bottomLeft = bottomLeftCorner
        , left = leftEdge
        }
