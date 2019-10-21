module PongBall exposing (..)

import PongHandleCollisions exposing (..)
import PongTypes exposing (..)
import Tuple exposing (first, second)


updateBall ball computer batY1 batY2 =
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
            && (collisionBat batY1 Left computer ball || collisionBat batY2 Right computer ball)
    then
        let
            currentSpeedSpin =
                ball.spinSpeed
        in
        { ball | speed = ( negate (first ball.speed), second ball.speed ), collisionDelay = 60, spinSpeed = negate currentSpeedSpin }

    else if outOfBoundaries ball computer then
        { ball | speed = ( 0, 0 ) }

    else
        newBall
