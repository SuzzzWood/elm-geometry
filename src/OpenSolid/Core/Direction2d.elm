{- This Source Code Form is subject to the terms of the Mozilla Public License,
   v. 2.0. If a copy of the MPL was not distributed with this file, you can
   obtain one at http://mozilla.org/MPL/2.0/.

   Copyright 2016 by Ian Mackenzie
   ian.e.mackenzie@gmail.com
-}


module OpenSolid.Core.Direction2d
    exposing
        ( x
        , y
        , ofVector
        , ofNonZeroVector
        , fromAngle
        , fromComponents
        , xComponent
        , yComponent
        , components
        , asVector
        , perpendicularTo
        , rotateBy
        , mirrorAcross
        , toLocalIn
        , fromLocalIn
        , negate
        , times
        , dotProduct
        , crossProduct
        , angleTo
        )

import OpenSolid.Core.Types exposing (..)
import OpenSolid.Core.Vector2d as Vector2d


x : Direction2d
x =
    Direction2d (Vector2d 1 0)


y : Direction2d
y =
    Direction2d (Vector2d 0 1)


{-| Attempt to find the direction of a vector. In the case of a zero vector,
return `Nothing`.

    Direction2d.ofVector (Vector2d 1 1) == Just (Direction2d (Vector2d 0.7071 0.7071))
    Direction2d.ofVector (Vector2d 0 0) == Nothing

For instance, given an eye point and a point to look at, the corresponding view
direction could be determined with

    Direction2d.ofVector (Point2d.vectorFrom eyePoint lookAtPoint)

This would return a `Maybe Direction2d`, with `Nothing` corresponding to the
case where the eye point and point to look at are coincident (in which case the
view direction is not well-defined and some special-case logic is needed).
-}
ofVector : Vector2d -> Maybe Direction2d
ofVector vector =
    if vector == Vector2d.zero then
        Nothing
    else
        Just (ofNonZeroVector vector)


ofNonZeroVector : Vector2d -> Direction2d
ofNonZeroVector vector =
    Direction2d (Vector2d.times (1 / Vector2d.length vector) vector)


fromAngle : Float -> Direction2d
fromAngle angle =
    Direction2d (Vector2d (cos angle) (sin angle))


fromComponents : ( Float, Float ) -> Direction2d
fromComponents =
    Vector2d.fromComponents >> Direction2d


xComponent : Direction2d -> Float
xComponent =
    asVector >> Vector2d.xComponent


yComponent : Direction2d -> Float
yComponent =
    asVector >> Vector2d.yComponent


components : Direction2d -> ( Float, Float )
components =
    asVector >> Vector2d.components


asVector : Direction2d -> Vector2d
asVector (Direction2d vector) =
    vector


perpendicularTo : Direction2d -> Direction2d
perpendicularTo =
    asVector >> Vector2d.perpendicularTo >> Direction2d


rotateBy : Float -> Direction2d -> Direction2d
rotateBy angle =
    asVector >> Vector2d.rotateBy angle >> Direction2d


mirrorAcross : Axis2d -> Direction2d -> Direction2d
mirrorAcross axis =
    asVector >> Vector2d.mirrorAcross axis >> Direction2d


toLocalIn : Frame2d -> Direction2d -> Direction2d
toLocalIn frame =
    asVector >> Vector2d.toLocalIn frame >> Direction2d


fromLocalIn : Frame2d -> Direction2d -> Direction2d
fromLocalIn frame =
    asVector >> Vector2d.fromLocalIn frame >> Direction2d


negate : Direction2d -> Direction2d
negate =
    asVector >> Vector2d.negate >> Direction2d


times : Float -> Direction2d -> Vector2d
times scale =
    asVector >> Vector2d.times scale


dotProduct : Direction2d -> Direction2d -> Float
dotProduct firstDirection secondDirection =
    Vector2d.dotProduct (asVector firstDirection) (asVector secondDirection)


crossProduct : Direction2d -> Direction2d -> Float
crossProduct firstDirection secondDirection =
    Vector2d.crossProduct (asVector firstDirection) (asVector secondDirection)


angleTo : Direction2d -> Direction2d -> Float
angleTo other direction =
    atan2 (crossProduct direction other) (dotProduct direction other)