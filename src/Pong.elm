module Pong exposing (..)

import Html exposing (..)
import Playground exposing (..)
import PongAssets exposing (..)
import PongBall exposing (..)
import PongColors exposing (..)
import PongHandleCollisions exposing (..)
import PongPositions exposing (..)
import PongTypes exposing (..)
import Set
import Tuple exposing (first, second)



-- MAIN


main =
    game view update initialGameState



-- VIEW


view computer gameState =
    [ bat orangeElm
        |> moveX (computer.screen.left + 50)
        |> moveY gameState.batY1
    , bat green
        |> moveRight (computer.screen.right - 50)
        |> moveY gameState.batY2
    , ball
        |> moveX (first gameState.ball.coords)
        |> moveY (second gameState.ball.coords)
        |> rotate (spin gameState.ball.spinSpeed computer.time)
    , words orangeElm "PONG = ELM GAME"
        |> scale 3
        |> moveUp (computer.screen.top - 50)
    ]



-- UPDATE


update computer gameState =
    let
        currentYBat1 =
            gameState.batY1

        currentYBat2 =
            gameState.batY2

        keys =
            computer.keyboard.keys

        top =
            computer.screen.top

        bottom =
            computer.screen.bottom

        newYBat1 =
            futurePositionBat1 currentYBat1 keys top bottom

        newYBat2 =
            futurePositionBat2 currentYBat2 computer.keyboard top bottom

        speedBallY =
            ballSpeedY computer.screen.height

        speedBallX =
            ballSpeedX computer.screen.width

        ballInitialSpeed ball =
            { ball | speed = ( speedBallX, speedBallY ) }

        newBall =
            updateBall gameState.ball computer newYBat1 newYBat2
                |> futurePositionBall
    in
    if first gameState.ball.speed == 0 then
        { gameState | ball = ballInitialSpeed gameState.ball }

    else
        { gameState | batY1 = newYBat1, batY2 = newYBat2, ball = newBall }



-- MODEL


initialGameState : GameState
initialGameState =
    { batY1 = 0
    , batY2 = 0
    , ball =
        { coords = ( 0, 0 )
        , speed = ( 0, 0 )
        , collisionDelay = 15
        , spinSpeed = -0.8
        }
    }



-- HELPERS


ballSpeedX : Number -> Number
ballSpeedX dim =
    toFloat (round ((dim / 60) * 0.5))


ballSpeedY : Number -> Number
ballSpeedY dim =
    toFloat (round ((dim / 60) * 0.7))
