module View exposing (view)

import Types as Types
import Components exposing (..)
import Preview.View exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)


view : Types.Model -> Html Types.Msg
view model =
    div [ class "workspace" ]
        [ toolbar model
        , div [ class "split-view" ]
            [ div [ class "sidebar" ]
                [ sizeEditor model.previewSize model.stretchPreview
                , marginsInput model.margins model.showMarginsOverlay
                ]
            , div
                [ class
                    ("bigger-bit"
                        ++ if model.stretchPreview then
                            " stretch-contents"
                           else
                            ""
                    )
                ]
                [ imageMarginsEditor model
                ]
            ]
        ]
