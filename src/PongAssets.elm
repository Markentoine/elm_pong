module PongAssets exposing (..)

import Playground exposing (..)
import PongColors exposing (..)


bat : Color -> Shape
bat color =
    rectangle color 15 200


ball : Shape
ball =
    group
        [ square green 99
            |> rotate 45
            |> moveRight 78
        , grandTriangle grisBleu
        , grandTriangle bleuClair
            |> rotate 90
        , moyenTriangle
        , petitTriangle
        , petitTriangle
            |> rotate 270
            |> moveDown 80
            |> moveRight 80
        , parallelogramme
        ]
        |> scale 0.08
