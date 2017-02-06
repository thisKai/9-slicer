port module Ports exposing (..)

import Types exposing (OpenImageData, CropImageData)


port requestOpenUrl : () -> Cmd msg


port receiveUrl : (String -> msg) -> Sub msg


port openImage : (OpenImageData -> msg) -> Sub msg


port saveSlices : CropImageData -> Cmd msg
