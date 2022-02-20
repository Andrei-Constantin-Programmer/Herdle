module Core where

import Base
import Helpers
import System.Win32.Types (BOOL)

-- Part B - Core functionality

-- The output should be a list of the guess characters (in order), paired with their status with respect to the actual word
checkGuess :: String -> String -> [(Char, Status)]
checkGuess [] _ = []
checkGuess (g: guess) word = (g, findChar (length word - length guess) 1 g word): checkGuess guess word

-- Try to find the char (with a given position x) in the given string and return an appropriate status
findChar :: Int -> Int -> Char -> String -> Status
findChar x y c "" = Nowhere
findChar x y c (element: string) =
    if((x==y && c==element) || checkHere x (y+1) c string) then Here
    else if(c == element)
        then 
            if (x > y) then Elsewhere (Just Before)
            else Elsewhere (Just After) 
    else findChar x (y+1) c string

-- Check if the char exists in the string at the given position
checkHere :: Int -> Int -> Char -> String -> Bool
checkHere x y c "" = False 
checkHere x y c (element: string) = 
    if(y>x) then False 
    else if (x==y && c == element) then True
    else checkHere x (y+1) c string