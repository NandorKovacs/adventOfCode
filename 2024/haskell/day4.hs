module Main where

import Control.Exception (catch)
import Data.List (isPrefixOf, transpose, zip4)
import System.IO.Error (isEOFError)

main :: IO ()
main = do
  s <- parse
  -- print $ diagonal s
  print $ firstTask s
  print $ secondTask s

parse :: IO [String]
parse = do
  l <- getLine `catch` (\e -> if isEOFError e then return "" else ioError e)
  if l == ""
    then return []
    else do
      t <- parse
      return (l : t)

countLine :: String -> Int
countLine [] = 0
countLine xs
  | "SAMX" `isPrefixOf` xs = 1 + countLine (tail xs)
  | "XMAS" `isPrefixOf` xs = 1 + countLine (tail xs)
  | otherwise = countLine (tail xs)

horizontal :: [String] -> Int
horizontal [] = 0
horizontal (x:xs) = horizontal xs + countLine x

vertical :: [String] -> Int
vertical xs = horizontal $ transpose xs

diagonal :: [String] -> Int
diagonal (x : y : z : w : xs) = diagonal (y:z:w:xs)
  + length (filter (\a -> a == ('X', 'M', 'A', 'S') || a == ('S', 'A', 'M', 'X')) diagTouples)
  where diagTouples = zip4 x (drop 1 y) (drop 2 z) (drop 3 w)
diagonal _ = 0

firstTask :: [String] -> Int
firstTask xs = horizontal xs + vertical xs + diagonal xs + diagonal (map reverse xs)

goodDigit :: Char -> Bool
goodDigit x = x == 'S' || x == 'M'

goodPairs :: Char -> Char -> Char -> Char -> Bool
goodPairs x y z w
  | not (goodDigit x && goodDigit y && goodDigit z && goodDigit w) = False
  | x == y = not (z /= w || z == x)
  | x == z = not (y /= w || y == x)
  | otherwise = False

countTriple :: (String, String , String) -> Int
countTriple (ax:ay:az:as, bx:by:bz:bs, cx:cy:cz:cs) = x + countTriple (ay:az:as, by:bz:bs, cy:cz:cs)
  where x
          | goodPairs ax az cx cz && by == 'A' = 1
          | otherwise = 0
countTriple (_, _, _) = 0

secondTask :: [String] -> Int
secondTask (x:y:z:xs) = countTriple (x,y,z) + secondTask (y:z:xs)
secondTask _ = 0