module PongTypes exposing (..)

import Playground exposing (..)


type alias GameState =
    { batY1 : Number
    , batY2 : Number
    , ball : BallState
    }


type alias BallState =
    { coords : ( Number, Number )
    , speed : ( Number, Number )
    , collisionDelay : Int
    , spinSpeed : Number
    }


type BatSide
    = Left
    | Right
