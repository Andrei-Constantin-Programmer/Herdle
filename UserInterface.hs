module UserInterface where

import Base
import Helpers
import GHC.Base (IO(IO))
import Data.Char

-- Part C - receiving guesses

getGuess :: Int -> IO String 
getGuess 0 = do
    putChar '\n'
    return ""
getGuess count = do
    input <- getChar'
    putChar ' ' 
    do
        remaining <- getGuess (count-1)
        return (toLower input: remaining)



-- Part D - gameplay