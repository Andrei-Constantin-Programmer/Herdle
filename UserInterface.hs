module UserInterface where

import Base
import Helpers
import GHC.Base (IO(IO))
import Data.Char
import Data.Binary.Get (remaining)

-- Part C - receiving guesses

-- Read the guess and output it as a string
getGuess :: Int -> String -> IO String 
getGuess 0 _ = do
    putChar '\n'
    return ""
getGuess count list = do
    input <- getChar'
    putChar ' ' 
    do
        case checkGuessChar input list of
            True -> do
                        remaining <- getGuess (count-1) list
                        return (toLower input: remaining)
            False -> do
                        putChar '\b'
                        putChar '\b'
                        remaining <- getGuess (count) list
                        return remaining

checkGuessChar :: Char -> String -> Bool 
checkGuessChar c "" = False 
checkGuessChar c (elem: string) = c==elem || checkGuessChar c string

-- Part D - gameplay