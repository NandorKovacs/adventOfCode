module Main where

import Control.Exception (catch)
import Data.Char (isDigit)
import System.IO.Error (isEOFError)

main :: IO ()
main = do
  s <- parse
  print $ firstTask s

parse :: IO [String]
parse = do
  l <- getLine `catch` (\e -> if isEOFError e then return "" else ioError e)
  if l == ""
    then return []
    else do
      t <- parse
      return (l : t)

matchInt :: String -> Maybe (String, String)
matchInt [] = Nothing
matchInt (x : xs) =
  if isDigit x
    then Just (x:i, s)
    else Nothing
  where
    (i, s) = case matchInt xs of
      Nothing -> ("", xs)
      Just (i, s) -> (i, s)

matchMul :: String -> Int
matchMul [] = 0
matchMul s | length s < 8 = 0
matchMul ('m' : 'u' : 'l' : '(' : s) =
  case matchInt s of
    Nothing -> matchMul s
    Just (i, t) ->
      if head t == ','
        then case matchInt $ tail t of
          Nothing -> matchMul s
          Just (j, tt) ->
            if head tt == ')'
              then (read i * read j) + matchMul (tail tt)
              else matchMul s
        else matchMul s
matchMul (x:xs) = matchMul xs

firstTask :: [String] -> Int
firstTask = foldr ((+) . matchMul) 0