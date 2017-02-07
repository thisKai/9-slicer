module Types exposing (..)

import Preview.Types as Preview
import Mouse exposing (Position)


type Msg
    = NoOp
    | RequestOpenUrl
    | RequestSaveSlices
    | OpenImage SourceImageData
    | PreviewMessage Preview.Msg


type alias Model =
    { sourceImage : Maybe SourceImageData
    , previewSize : Size
    , stretchPreview : Bool
    , margins : Preview.Margins
    , showMarginsOverlay : Bool
    , drag : Maybe (DragData Preview.MarginDragData)
    }


type alias SourceImageData =
    { url : String
    , size : Size
    }


type ImageSource
    = Nowhere
    | Url String


type alias Size =
    { width : Int
    , height : Int
    }


type alias DragData a =
    { start : Position
    , current : Position
    , data : a
    }


type alias CropRect =
    { left : Int
    , top : Int
    , right : Int
    , bottom : Int
    , width : Int
    , height : Int
    }


type alias CropDimensions =
    { topLeft : CropRect
    , top : CropRect
    , topRight : CropRect
    , right : CropRect
    , bottomRight : CropRect
    , bottom : CropRect
    , bottomLeft : CropRect
    , left : CropRect
    }


type alias CropImageData =
    { imageUrl : String
    , dimensions : CropDimensions
    }
