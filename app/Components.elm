module Components exposing (..)

import Types exposing (..)
import Preview.Types as Preview
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


changeMarginSizeMsg : String -> String -> Msg
changeMarginSizeMsg dimension text =
    Types.PreviewMessage (Preview.ChangeSize dimension text)


changeStretchPreviewMsg : Bool -> Msg
changeStretchPreviewMsg stretch =
    Types.PreviewMessage (Preview.ChangeStretchPreview stretch)


sizeEditor : Size -> Bool -> Html Msg
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


toolbar : Model -> Html Msg
toolbar model =
    let
        disableSaveButton =
            case model.sourceImage of
                Nothing ->
                    True

                Just src ->
                    False
    in
        div [ class "toolbar" ]
            [ button [ onClick RequestOpenUrl ] [ text "Open" ]
            , div [ class "spacer" ] []
            , tabBar
                { tabs =
                    [ { id = 0, title = "Margins" }
                    , { id = 1, title = "Slices" }
                    ]
                , selectedIndex = 1
                }
            , div [ class "spacer" ] []
            , button
                [ onClick RequestSaveSlices, disabled disableSaveButton ]
                [ text "Save" ]
            ]


type alias TabOptions a =
    { id : a
    , title : String
    }


type alias TabBarOptions a =
    { tabs : List (TabOptions a)
    , selectedIndex : Int
    }


tabBar : TabBarOptions a -> Html Msg
tabBar options =
    div [ class "tab-bar" ]
        (List.map
            (\{ id, title } ->
                (div [ class "tab" ] [ text title ])
            )
            options.tabs
        )
