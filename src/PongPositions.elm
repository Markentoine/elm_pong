module PongPositions exposing (..)

import PongPlayground exposing (toY)
import Set exposing (member)
import Tuple exposing (first, second)


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
