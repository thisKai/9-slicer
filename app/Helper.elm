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
