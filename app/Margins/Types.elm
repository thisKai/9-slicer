module Margins.Types exposing (..)

import Mouse exposing (Position)


type Msg
    = RequestOpenUrl
    | ChangeSource String
    | ChangeSize String String
    | ChangeStretchPreview Bool
    | ChangeMargins Side String
    | ChangeMarginPreviewVisibility Bool
    | MarginDragStart Side Position
    | MarginDragMove Side Position
    | MarginDragEnd Side Position


type Source
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


type alias DragData =
    { side : Side
    , start : Position
    , current : Position
    , startMargins : Margins
    }
