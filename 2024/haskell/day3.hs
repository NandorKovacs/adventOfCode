module Main where

import Control.Exception (catch)
import Data.Char (isDigit)
import System.IO.Error (isEOFError)
import Data.Tree (flatten)

main :: IO ()
main = do
  s <- parse
  print $ firstTask $ concat s
  print $ secondTask $ concat s

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

firstTask :: String -> Int
firstTask [] = 0
firstTask s | length s < 8 = 0
firstTask ('m' : 'u' : 'l' : '(' : s) =
  case matchInt s of
    Nothing -> firstTask s
    Just (i, t) ->
      if head t == ','
        then case matchInt $ tail t of
          Nothing -> firstTask s
          Just (j, tt) ->
            if head tt == ')'
              then (read i * read j) + firstTask (tail tt)
              else firstTask s
        else firstTask s
firstTask (x:xs) = firstTask xs

preprocessDo :: String -> String
preprocessDo s | length s < 4 = s
preprocessDo ('d':'o':'(':')':s) = preprocessDon't s
preprocessDo (s:xs) = preprocessDo xs

preprocessDon't :: String -> String
preprocessDon't s | length s < 7 = s
preprocessDon't ('d':'o':'n':'\'':'t':'(':')':s) = preprocessDo s
preprocessDon't (s:xs) = s:preprocessDon't xs

secondTask :: String -> Int
secondTask xs = firstTask $ preprocessDon't xs