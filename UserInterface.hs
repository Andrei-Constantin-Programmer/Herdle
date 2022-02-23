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
        case input of
            '.' -> do
                    putChar '\b'
                    putChar '\b'
                    putChar '\b'
                    putChar '\b'

                    remaining <- getGuess (count+1) list
                    return ('\b': remaining)
            _ -> do
                case checkGuessChar input list of
                    True -> do
                                remaining <- getGuess (count-1) list
                                if(backspaceLast remaining) then
                                    return (removeFirst remaining) 
                                else
                                    return (toLower input: remaining)
                    False -> do
                                putChar '\b'
                                putChar '\b'
                                remaining <- getGuess (count) list
                                return remaining

removeFirst :: [a] -> [a]
removeFirst [] = []
removeFirst (x:xs) = xs

backspaceLast :: [Char] -> Bool
backspaceLast ('\b': list) = True
backspaceLast _ = False

checkGuessChar :: Char -> String -> Bool 
checkGuessChar c "" = False 
checkGuessChar c (elem: string) = c==elem || checkGuessChar c string



-- Part D - gameplay