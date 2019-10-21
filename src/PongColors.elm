module PongColors exposing (..)

import Playground exposing (..)


grisBleu =
    rgb 89 99 120


bleuClair =
    rgb 96 181 204


orangeElm =
    rgb 241 173 0


grandTriangle color =
    polygon color [ ( -10, 0 ), ( -150, 140 ), ( -150, -140 ) ]


moyenTriangle =
    polygon bleuClair [ ( 150, -20 ), ( 150, -150 ), ( 20, -150 ) ]


petitTriangle =
    polygon orangeElm [ ( 0, -10 ), ( -60, -70 ), ( 60, -70 ) ]


parallelogramme =
    polygon green [ ( 65, -83 ), ( -75, -83 ), ( -140, -150 ), ( 0, -150 ) ]
