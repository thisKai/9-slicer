module Types exposing (..)

import Preview.Types as Preview


type Msg
    = NoOp
    | RequestOpenUrl
    | ChangeImageSource String
    | PreviewMessage Preview.Msg


type alias Model =
    { source : ImageSource
    , previewSize : Size
    , stretchPreview : Bool
    , margins : Preview.Margins
    , showMarginsPreview : Bool
    , drag : Maybe Preview.DragData
    }


type alias OpenImageData =
    { sourceUri : Maybe String
    , size : Size
    }


type ImageSource
    = Nowhere
    | Url String


type alias Size =
    { width : Int
    , height : Int
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
