-----------------------------------------------------------------------------
--
-- Module      :  Main
-- Copyright   :
-- License     :  AllRightsReserved
--
-- Maintainer  :
-- Stability   :
-- Portability :
--
-- |
--
-----------------------------------------------------------------------------

module Main (
    main,
    mysqrt,
    newtonRaphson,
    deriv,
    infinitelist
) where

-- This strang looking comment adds code only needed when running the
-- doctest tests embedded in the comments
-- $setup
-- >>> import Data.List (stripPrefix)

-- | Simple function to create a hello message.
-- prop> stripPrefix "Hello " (hello s) == Just s
hello :: String -> String
hello s = "Hello " ++ s

main :: IO ()
main = putStrLn (hello "World")
-- main = putStrLn (mysqrt 2 1)

newtonRaphson :: (RealFloat a) => a -> (a -> a) -> a
newtonRaphson guess f
  | difference <= epsilon = newguess
  | otherwise = newtonRaphson newguess f
  where
    newguess = guess - f guess/fprime guess
    difference = abs(newguess - guess)
    epsilon = 0.002
    fprime = deriv f

mysqrt :: (RealFloat a) => a -> a -> a
mysqrt a x
  | difference <= epsilon = newguess
  | otherwise = mysqrt a newguess
  where
    newguess = 1 / 2 * (x + a/x)
    difference = abs(newguess - x)
    epsilon = 0.02

deriv :: (RealFloat a) => (a->a) -> a -> a
deriv f x = (f (x + dx) - f x) / dx
    where dx = 0.0001*x

-- Some example functions that I don't use
-- g :: (RealFloat a) => a -> a
-- g x = x^3 - 4*x + 1

-- g2 :: (RealFloat a) => a -> a -> a
-- g2 y x = x*y

-- Euler method
euler :: (Double->Double) -> Double -> Double
euler f y0 = y0 + h * f y0
    where h = 0.1


infinitelist = 1.0 : map (+ 0.01) infinitelist
-- function, x0, y0

eulerIter f y0 = y0 : eulerIter f yp 
  where 
    yp = euler f y0 

{-eulerIter :: (Double->Double) -> Double -> Double -> [(Double,Double)]
eulerIter f x0 y0 = x
  where 
    dx = 0.001
    yp = euler f y0
    x = 1.0 : map (+ dx) x
    -}

-- Modified Euler method
{-
eulerModified :: (RealFloat a) => (a->a->a) -> a -> a -> a
eulerModified f y0 x0 = y0 + h/2 * ( yp0 + yp1)
  where
    yp0 = f y0 x0
    yp1 = euler f y0 x0
    h = 0.0001
-}

mag :: (RealFloat a) => [a] -> a
mag [] = 0
mag v = sqrt(sumsqr)
  where sumsqr = foldr (\x y -> x^2 + y) 0 v

dot :: (RealFloat a) => [a] -> [a] -> Maybe a
dot [] [] = Just 0.0
dot (x:xs) [] = Nothing
dot [] (x:xs) = Nothing
dot (x:xs) (y:ys) =  case dot xs ys of
   Just r -> Just(x * y + r)
   Nothing -> Nothing

myreverse :: [Char] -> [Char]
myreverse [] = []
myreverse (x:xs) = myreverse xs ++ [x]
{-
angle :: (RealFloat a) => [a] -> [a] -> Maybe a
angle a b = acos(t)
  where t = (dot a b) / (mag a * mag b)
-}

  -- gprime :: (RealFloat a) => a -> a
-- gprime x = 3*x^2 - 4

