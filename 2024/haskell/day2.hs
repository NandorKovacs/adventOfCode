module Main where
import Control.Exception (catch)
import System.IO.Error (isEOFError)

main :: IO ()
main = do
  p <- parse
  print $ firstTask p
  print $ secondTask p

parse :: IO [[Int]]
parse = do
  line <- catch getLine (\e -> if isEOFError e then return "" else ioError e)
  if line == ""
    then return []
    else do
      list <- parse
      let l = map read $ words line
      return (l:list)



safeReport :: [Int] -> Bool
safeReport x = let diff = zipWith (-) x (tail x) in
  abs (sum (map signum diff)) == length x - 1
  && all (\x -> abs x >= 1 && abs x <= 3) diff

firstTask :: [[Int]] -> Int
firstTask l = length $ filter id (map safeReport l)

checkPair :: Int -> Int -> Int -> Bool
checkPair x y z = signum (x-y) == signum (y-z) && 0 < abs (x-y) && abs (x-y) < 4


-- greedy doesn't work of course
-- toleratingReport :: [Int] -> [Int]
-- toleratingReport (x:y:z:xs)
--   | checkPair x y z = x:toleratingReport (y:z:xs)
--   | otherwise = toleratingReport (y:z:xs)
-- toleratingReport xs = xs

secondTask :: [[Int]] -> Int
secondTask l = length $ filter id (map secondTaskCheese l)
-- secondTask l = length $ filter (\x -> length x >= (n - 1)) (map toleratingReport l)
--   where n = length (head l)



secondTaskCheese :: [Int] -> Bool
secondTaskCheese x
  | safeReport x = True
  | or ([safeReport (take y x ++ drop (y + 1) x) | y <- [0..length x]]) = True
  | otherwise = False