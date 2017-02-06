module Helper exposing (..)

import Types exposing (..)
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

