module PongAssets exposing (..)

import PongColors exposing (..)
import PongPlayground exposing (..)


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


buttonPlayerOne =
    group
        [ rectangle orangeElm 90 20
        , words white "P1#HUMAN"
        ]


buttonPlayerTwo =
    group
        [ rectangle green 90 20
        , words white "P2#HUMAN"
        ]
