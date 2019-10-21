module PongHandleCollisions exposing (..)

import Playground exposing (..)
import PongTypes exposing (..)
import Tuple exposing (first, second)


collisionBat : Number -> BatSide -> Computer -> BallState -> Bool
collisionBat batY side computer ball =
    let
        batX =
            case side of
                Left ->
                    computer.screen.left + 50

                Right ->
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
