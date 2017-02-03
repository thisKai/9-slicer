port module Ports exposing (..)


port requestOpenUrl : () -> Cmd msg


port receiveUrl : (String -> msg) -> Sub msg
