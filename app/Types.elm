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


type alias CropRect =
    { left : Int
    , top : Int
    , right : Int
    , bottom : Int
    }


type alias CropDimensions =
    { topLeftCorner : CropRect
    , topEdge : CropRect
    , topRightCorner : CropRect
    , rightEdge : CropRect
    , bottomRightCorner : CropRect
    , bottomEdge : CropRect
    , bottomLeftCorner : CropRect
    , leftEdge : CropRect
    }
