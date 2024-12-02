module Main where

import Control.Exception ( catch )
import Data.List ( sort )
import System.IO.Error ( isEOFError )

main :: IO ()
main = do
  p <- parse
  print $ firstTask p
  print $ secondTask p


-- there is a bug if there are exactly two lines in the input :/
parse :: IO ([Int], [Int])
parse = do
  line <- catch getLine (\e -> if isEOFError e then return "" else ioError e)
  if line == ""
    then return ([], [])
    else do
      let (x : y : _) = words line
      (xs, ys) <- parse
      return (read x : xs, read y : ys)

firstTask :: ([Int], [Int]) -> Int
firstTask (x, y) = sum $ zipWith (\x y -> abs (x - y)) (sort x) (sort y)


secondTask :: ([Int], [Int]) -> Int
secondTask (x, y) = sum $ map (\a -> a * length (filter (a==) y)) x