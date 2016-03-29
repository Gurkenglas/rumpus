{-# LANGUAGE FlexibleContexts #-}
module Tree where
import Rumpus

-- Golden Section Spiral 
-- (via http://www.softimageblog.com/archives/115)
pointsOnSphere (fromIntegral -> n) = 
    let inc = pi * (3 - sqrt 5)
        off = 2 / N
    in flip map [0..n] $ \k ->
        let y = k * off - 1 + (off / 2)
            r = sqrt (1 - y*y)
            phi = k * inc
        in V3 (cos phi * r) y (sin phi *r

start :: OnStart
start = do
    removeChildren
    rootEntityID <- ask
    
    let numPoints = 30
        sphere = pointsOnSphere numPoints
        hues = map (/ fromIntegral numPoints) [0..numPoints]
    forM_ (zip sphere hues) $ \(pos, hue) -> void $ spawnEntity Transient $ do
        cmpParent                 ==> rootEntityID
        cmpPose                   ==> mkTransformation 
                                        (axisAngle (V3 0 0 1) 0.3) pos
        cmpShapeType              ==> SphereShape
        cmpPhysicsProperties      ==> [NoPhysicsShape]
        cmpInheritParentTransform ==> InheritFull
        cmpSize                   ==> V3 0.5 0.5 0.5
        cmpColor                  ==> hslColor (fromIntegral n/9) 0.8 0.5
        cmpOnUpdate ==> do
            now <- sin <$> getNow
            let V3 pX pY pZ = pos
            cmpPose ==> mkTransformation 
                (axisAngle (V3 0 1 1) (now*2)) 
                (V3 (pX+now) pY pZ)
    return Nothing