module Preview.Types exposing (..)

import Mouse exposing (Position)


type Msg
    = ChangeSize String String
    | ChangeStretchPreview Bool
    | ChangeMargins Side String
    | ChangeMarginPreviewVisibility Bool
    | MarginDragStart Side Position
    | MarginDragMove Side Position
    | MarginDragEnd Side Position
    | PreviewResizeStart ResizeEdge Position
    | PreviewResizeMove ResizeEdge Position
    | PreviewResizeEnd ResizeEdge Position


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


type alias MarginDragData =
    { side : Side
    , startMargin : Margins
    }
