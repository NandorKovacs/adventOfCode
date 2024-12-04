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

-- this doesn't work yet
toleratingReport :: [Int] -> [Int]
toleratingReport [] = []
toleratingReport (x:xs)
  | length t < 2 = x:t
  | checkPair x (head t) (t !! 1) = x:t
  | otherwise = t
  where t = toleratingReport xs

secondTask :: [[Int]] -> Int
secondTask l = length $ filter id (map (\l -> length (toleratingReport l) >= length l - 1) l)