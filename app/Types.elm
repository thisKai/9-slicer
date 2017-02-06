module Types exposing (..)

import Preview.Types as Preview


type Msg
    = NoOp
    | RequestOpenUrl
    | ChangeImageSource String
    | PreviewMessage Preview.Msg


type alias Model =
    { source : Preview.ImageSource
    , previewSize : Preview.Size
    , stretchPreview : Bool
    , margins : Preview.Margins
    , showMarginsPreview : Bool
    , drag : Maybe Preview.DragData
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


type alias CropImageData =
    { imageUri : String
    , dimensions : CropDimensions
    }
