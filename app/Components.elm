module Components exposing (..)

import Types exposing (..)
import Helper exposing (..)
import Margins.Types as Margins
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import String

changeMarginSizeMsg dimension text =
  Types.ImageSlicerMessage (Margins.ChangeSize dimension text)

changeStretchPreviewMsg stretch =
  Types.ImageSlicerMessage (Margins.ChangeStretchPreview stretch)

sizeEditor size stretchPreview =
    div []
        [ h1 [] [ text "Preview Size" ]
        , input [ type_ "number", value (toString size.width), onInput (changeMarginSizeMsg "width"), disabled stretchPreview ] []
        , text "width"
          --, text (utf 0x2003)
        , br [] []
        , input [ type_ "number", value (toString size.height), onInput (changeMarginSizeMsg "height"), disabled stretchPreview ] []
        , text "height"
        , label
            []
            [ input [ type_ "checkbox", checked stretchPreview, onCheck changeStretchPreviewMsg ] []
            , text "Stretch Preview"
            ]
        ]


toolbar =
    div [ class "toolbar" ]
        [ button [ onClick (Types.ImageSlicerMessage Margins.RequestOpenUrl) ] [ text "Open" ]
        , div [ class "spacer" ] []
        , tabBar
            { tabs =
                [ { id = 0, title = "Margins" }
                , { id = 1, title = "Slices" }
                ]
            , selectedIndex = 1
            }
        , div [ class "spacer" ] []
        , button [] [ text "Save" ]
        ]


type alias TabOptions a =
    { id : a
    , title : String
    }


type alias TabBarOptions a =
    { tabs : List (TabOptions a)
    , selectedIndex : Int
    }


tabBar options =
    div [ class "tab-bar" ]
        (List.map
            (\{ id, title } ->
                (div [ class "tab" ] [ text title ])
            )
            options.tabs
        )
