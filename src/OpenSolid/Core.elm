module OpenSolid.Core
  ( Vector2d
  , Vector3d
  , Point2d
  , Point3d
  , Direction2d
  , Direction3d
  , Interval
  , Bounds2d
  , Bounds3d
  , LineSegment2d
  , LineSegment3d
  , Triangle2d
  , Triangle3d
  , Axis2d
  , Axis3d
  , Plane3d
  , Frame2d
  , Frame3d
  , Transformation2d
  , Transformation3d
  ) where


-- Interval


type alias Interval =
  { lowerBound: Float
  , upperBound: Float
  }


-- Cartesian values


type alias Vector2d =
  { x: Float
  , y: Float
  }


type alias Vector3d =
  { x: Float
  , y: Float
  , z: Float
  }


type alias Point2d =
  { x: Float
  , y: Float
  }


type alias Point3d =
  { x: Float
  , y: Float
  , z: Float
  }


type alias Direction2d =
  { x: Float
  , y: Float
  }


type alias Direction3d =
  { x: Float
  , y: Float
  , z: Float
  }


type alias Bounds2d =
  { x: Interval
  , y: Interval
  }


type alias Bounds3d =
  { x: Interval
  , y: Interval
  , z: Interval
  }


-- Simplices


type alias LineSegment2d =
  { firstEndpoint: Point2d
  , secondEndpoint: Point2d
  }


type alias LineSegment3d =
  { firstEndpoint: Point3d
  , secondEndpoint: Point3d
  }


type alias Triangle2d =
  { firstVertex: Point2d
  , secondVertex: Point2d
  , thirdVertex: Point2d
  }


type alias Triangle3d =
  { firstVertex: Point3d
  , secondVertex: Point3d
  , thirdVertex: Point3d
  }


-- Datums


type alias Axis2d =
  { originPoint: Point2d
  , direction: Direction2d
  }


type alias Axis3d =
  { originPoint: Point3d
  , direction: Direction3d
  }


type alias Plane3d =
  { originPoint: Point3d
  , xDirection: Direction3d
  , yDirection: Direction3d
  , normalDirection: Direction3d
  }


type alias Frame2d =
  { originPoint: Point2d
  , xDirection: Direction2d
  , yDirection: Direction2d
  }


type alias Frame3d =
  { originPoint: Point3d
  , xDirection: Direction3d
  , yDirection: Direction3d
  , zDirection: Direction3d
  }


-- Transformations


type alias Transformation2d =
  { transformVector: Vector2d -> Vector2d
  , transformPoint: Point2d -> Point2d
  }


type alias Transformation3d =
  { transformVector: Vector3d -> Vector3d
  , transformPoint: Point3d -> Point3d
  }
