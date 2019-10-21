module Pong exposing (..)

import Html exposing (..)
import Playground exposing (..)
import PongAssets exposing (..)
import PongColors exposing (..)
import Set
import Tuple exposing (first, second)



-- MAIN


main =
    game view update initialGameState



-- VIEW


view computer gameState =
    [ bat orangeElm
        |> moveX (computer.screen.left + 50)
        |> moveY gameState.bat1
    , bat green
        |> moveRight (computer.screen.right - 50)
        |> moveY gameState.bat2
    , ball
        |> moveX (first gameState.ball.coords)
        |> moveY (second gameState.ball.coords)
        |> rotate (spin gameState.ball.spinSpeed computer.time)
    , words orangeElm "ELM |> PONG"
        |> scale 3
        |> moveUp (computer.screen.top - 50)

    --|> rotate (spin -0.8 computer.time)
    ]



-- UPDATE


update computer gameState =
    let
        currentYBat1 =
            gameState.bat1

        currentYBat2 =
            gameState.bat2

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
        { gameState | bat1 = newYBat1, bat2 = newYBat2, ball = newBall }



-- MODEL


type alias GameState =
    { bat1 : Number
    , bat2 : Number
    , ball : BallState
    }


type alias BallState =
    { coords : ( Number, Number )
    , speed : ( Number, Number )
    , collisionDelay : Int
    , spinSpeed : Number
    }


initialGameState : GameState
initialGameState =
    { bat1 = 0
    , bat2 = 0
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
    toFloat (round ((dim / 60) * 0.3))


ballSpeedY : Number -> Number
ballSpeedY dim =
    toFloat (round ((dim / 60) * 0.7))


futurePositionBat1 currentPosition keys top bottom =
    if Set.member "q" keys then
        if currentPosition + 15 + 100 > top then
            top - 100

        else
            currentPosition + 15

    else if Set.member "w" keys then
        if currentPosition - 15 - 100 < bottom then
            bottom + 100

        else
            currentPosition - 15

    else
        currentPosition


futurePositionBat2 currentPosition keyboard top bottom =
    let
        expectedTopPosition =
            currentPosition + 100 + toY keyboard

        expectedBottomPosition =
            currentPosition - 100 + toY keyboard
    in
    if expectedTopPosition > top then
        top - 100

    else if expectedBottomPosition < bottom then
        bottom + 100

    else
        currentPosition + toY keyboard * 15


reachTopBottom : ( Number, Number ) -> Number -> Number -> Number -> Bool
reachTopBottom ballCoords top bottom speedY =
    let
        ballY =
            second ballCoords
    in
    if ballY >= top then
        True

    else if ballY <= bottom then
        True

    else
        False


decCollisionDelay ball =
    let
        currentCollisionDelay =
            ball.collisionDelay
    in
    { ball | collisionDelay = currentCollisionDelay - 1 }


collisionBat1 : Number -> Computer -> BallState -> Bool
collisionBat1 batY computer ball =
    let
        batX =
            computer.screen.left + 50

        topBatY =
            batY + 100

        bottomBatY =
            batY - 100

        ballX =
            first ball.coords

        ballY =
            second ball.coords
    in
    (ballX >= batX - 8 && ballX <= batX + 8) && (ballY <= topBatY && ballY >= bottomBatY)


collisionBat2 : Number -> Computer -> BallState -> Bool
collisionBat2 batY computer ball =
    let
        batX =
            computer.screen.right - 50

        topBatY =
            batY + 100

        bottomBatY =
            batY - 100

        ballX =
            first ball.coords

        ballY =
            second ball.coords
    in
    (ballX >= batX - 8 && ballX <= batX + 8) && (ballY <= topBatY && ballY >= bottomBatY)


updateBall ball computer bat1 bat2 =
    let
        top =
            computer.screen.top

        bottom =
            computer.screen.bottom

        newBall =
            decCollisionDelay ball
    in
    if reachTopBottom ball.coords top bottom (second ball.speed) then
        { ball | speed = ( first ball.speed, negate (second ball.speed) ) }

    else if
        newBall.collisionDelay
            < 0
            && (collisionBat1 bat1 computer ball || collisionBat2 bat2 computer ball)
    then
        { ball | speed = ( negate (first ball.speed), second ball.speed ), collisionDelay = 60 }

    else if outOfBoundaries ball computer then
        { ball | speed = ( 0, 0 ) }

    else
        newBall


outOfBoundaries ball computer =
    first ball.coords < computer.screen.left + 5 || first ball.coords > computer.screen.right - 5


futurePositionBall currentBall =
    let
        currentPosition =
            currentBall.coords

        newPosition =
            ( first currentPosition + first currentBall.speed
            , second currentPosition + second currentBall.speed
            )
    in
    { currentBall | coords = newPosition }



-- check top and bottom
-- if true then reverse y
-- check collision bat1 & bat2
-- if true reverse x
-- check if beyond bat1 or bat2
-- if true end game
