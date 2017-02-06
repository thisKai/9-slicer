port module Ports exposing (..)

import Types exposing (CropImageData)


port requestOpenUrl : () -> Cmd msg


port receiveUrl : (String -> msg) -> Sub msg


port saveSlices : CropImageData -> Cmd msg
