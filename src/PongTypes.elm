module PongTypes exposing (..)

import Playground exposing (..)


type alias GameState =
    { state : State
    , batY1 : Number
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


type State
    = Start
    | Running
    | Pause
    | End
