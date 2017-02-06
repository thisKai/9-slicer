module Types exposing (..)

import Margins.Types as Margins


type Msg
    = NoOp
    | ImageSlicerMessage Margins.Msg


type alias Model =
    { source : Margins.ImageSource
    , previewSize : Margins.Size
    , stretchPreview : Bool
    , margins : Margins.Margins
    , showMarginsPreview : Bool
    , drag : Maybe Margins.DragData
    }
