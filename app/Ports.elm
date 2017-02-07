port module Ports exposing (..)

import Types exposing (SourceImageData, CropImageData)


port requestOpenUrl : () -> Cmd msg


port openImage : (SourceImageData -> msg) -> Sub msg


port saveSlices : CropImageData -> Cmd msg
