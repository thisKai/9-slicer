module Types exposing (..)

import Preview.Types as Preview


type Msg
    = NoOp
    | RequestOpenUrl
    | RequestSaveSlices
    | OpenImage OpenImageData
    | PreviewMessage Preview.Msg


type alias Model =
    { source : ImageSource
    , size : Size
    , previewSize : Size
    , stretchPreview : Bool
    , margins : Preview.Margins
    , showMarginsPreview : Bool
    , drag : Maybe Preview.DragData
    }


type alias OpenImageData =
    { sourceUrl : Maybe String
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
