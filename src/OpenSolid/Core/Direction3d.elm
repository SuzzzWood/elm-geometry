{- This Source Code Form is subject to the terms of the Mozilla Public License,
   v. 2.0. If a copy of the MPL was not distributed with this file, you can
   obtain one at http://mozilla.org/MPL/2.0/.

   Copyright 2016 by Ian Mackenzie
   ian.e.mackenzie@gmail.com
-}


module OpenSolid.Core.Direction3d
    exposing
        ( x
        , y
        , z
        , onPlane
        , ofVector
        , ofNonZeroVector
        , fromComponents
        , xComponent
        , yComponent
        , zComponent
        , components
        , asVector
        , perpendicularTo
        , perpendicularBasis
        , rotateAround
        , mirrorAcross
        , toLocalIn
        , fromLocalIn
        , projectOnto
        , projectInto
        , negate
        , times
        , dotProduct
        , crossProduct
        , angleTo
        )

import OpenSolid.Core.Types exposing (..)
import OpenSolid.Core.Vector2d as Vector2d
import OpenSolid.Core.Vector3d as Vector3d
import OpenSolid.Core.Direction2d as Direction2d


x : Direction3d
x =
    Direction3d (Vector3d 1 0 0)


y : Direction3d
y =
    Direction3d (Vector3d 0 1 0)


z : Direction3d
z =
    Direction3d (Vector3d 0 0 1)


onPlane : Plane3d -> Direction2d -> Direction3d
onPlane plane =
    Direction2d.asVector >> Vector3d.onPlane plane >> Direction3d


{-| Attempt to find the direction of a vector. In the case of a zero vector,
return `Nothing`.

    Direction3d.ofVector (Vector3d 1 0 1) == Just (Direction3d (Vector3d 0.7071 0 0.7071))
    Direction3d.ofVector (Vector3d 0 0 0) == Nothing

For instance, given an eye point and a point to look at, the corresponding view
direction could be determined with

    Direction3d.ofVector (Point3d.vectorFrom eyePoint lookAtPoint)

This would return a `Maybe Direction3d`, with `Nothing` corresponding to the
case where the eye point and point to look at are coincident (in which case the
view direction is not well-defined and some special-case logic is needed).
-}
ofVector : Vector3d -> Maybe Direction3d
ofVector vector =
    if vector == Vector3d.zero then
        Nothing
    else
        Just (ofNonZeroVector vector)


ofNonZeroVector : Vector3d -> Direction3d
ofNonZeroVector vector =
    Direction3d (Vector3d.times (1 / Vector3d.length vector) vector)


fromComponents : ( Float, Float, Float ) -> Direction3d
fromComponents =
    Vector3d.fromComponents >> Direction3d


xComponent : Direction3d -> Float
xComponent =
    asVector >> Vector3d.xComponent


yComponent : Direction3d -> Float
yComponent =
    asVector >> Vector3d.yComponent


zComponent : Direction3d -> Float
zComponent =
    asVector >> Vector3d.zComponent


components : Direction3d -> ( Float, Float, Float )
components =
    asVector >> Vector3d.components


asVector : Direction3d -> Vector3d
asVector (Direction3d vector) =
    vector


perpendicularTo : Direction3d -> Direction3d
perpendicularTo =
    asVector >> Vector3d.perpendicularTo >> ofNonZeroVector


perpendicularBasis : Direction3d -> ( Direction3d, Direction3d )
perpendicularBasis direction =
    let
        xDirection =
            perpendicularTo direction

        yDirection =
            Direction3d (crossProduct direction xDirection)
    in
        ( xDirection, yDirection )


rotateAround : Axis3d -> Float -> Direction3d -> Direction3d
rotateAround axis angle =
    asVector >> Vector3d.rotateAround axis angle >> Direction3d


mirrorAcross : Plane3d -> Direction3d -> Direction3d
mirrorAcross plane =
    asVector >> Vector3d.mirrorAcross plane >> Direction3d


toLocalIn : Frame3d -> Direction3d -> Direction3d
toLocalIn frame =
    asVector >> Vector3d.toLocalIn frame >> Direction3d


fromLocalIn : Frame3d -> Direction3d -> Direction3d
fromLocalIn frame =
    asVector >> Vector3d.fromLocalIn frame >> Direction3d


projectOnto : Plane3d -> Direction3d -> Maybe Direction3d
projectOnto plane =
    asVector >> Vector3d.projectOnto plane >> ofVector


projectInto : Plane3d -> Direction3d -> Maybe Direction2d
projectInto plane =
    asVector >> Vector3d.projectInto plane >> Direction2d.ofVector


negate : Direction3d -> Direction3d
negate =
    asVector >> Vector3d.negate >> Direction3d


times : Float -> Direction3d -> Vector3d
times scale =
    asVector >> Vector3d.times scale


dotProduct : Direction3d -> Direction3d -> Float
dotProduct firstDirection secondDirection =
    Vector3d.dotProduct (asVector firstDirection) (asVector secondDirection)


crossProduct : Direction3d -> Direction3d -> Vector3d
crossProduct firstDirection secondDirection =
    Vector3d.crossProduct (asVector firstDirection) (asVector secondDirection)


angleTo : Direction3d -> Direction3d -> Float
angleTo other direction =
    acos (dotProduct direction other)