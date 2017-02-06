module Margins.Types exposing (..)

import Mouse exposing (Position)


type Msg
    = RequestOpenUrl
    | ChangeImageSource String
    | ChangeSize String String
    | ChangeStretchPreview Bool
    | ChangeMargins Side String
    | ChangeMarginPreviewVisibility Bool
    | MarginDragStart Side Position
    | MarginDragMove Side Position
    | MarginDragEnd Side Position
    | PreviewResizeStart ResizeEdge Position
    | PreviewResizeMove ResizeEdge Position
    | PreviewResizeEnd ResizeEdge Position


type ImageSource
    = Nowhere
    | Url String


type alias Size =
    { width : Int
    , height : Int
    }


type Dimension
    = Width
    | Height


type alias Margins =
    { top : Int
    , right : Int
    , bottom : Int
    , left : Int
    }


type Side
    = None
    | Top
    | Right
    | Bottom
    | Left


type ResizeEdge
    = NoEdge
    | TopLeftCorner
    | TopEdge
    | TopRightCorner
    | RightEdge
    | BottomRightCorner
    | BottomEdge
    | BottomLeftCorner
    | LeftEdge


type alias DragData =
    { side : Side
    , start : Position
    , current : Position
    , startMargins : Margins
    }
