module UserInterface where

import Base
import Helpers
import Core
import GHC.Base (IO(IO))
import Data.Char
import Data.Binary.Get (remaining)

-- Part C - receiving guesses

-- Read the guess and output it as a string
getGuess :: Int -> String -> IO String 
getGuess max list = getGuessMax max max list

getGuessMax :: Int -> Int -> String -> IO String 
getGuessMax _ 0 _ = do
    putChar '\n'
    return ""
getGuessMax max count list = do
    input <- getChar'
    putChar ' ' 
    do
        case input of
            '.' -> do
                    putChar '\b'
                    putChar '\b'
                    putChar '\b'
                    putChar '\b'

                    if(count<max) then
                        do
                            remaining <- getGuessMax max (count+1) list
                            return ('\b': remaining)
                    else
                        do
                            remaining <- getGuessMax max count list
                            return remaining 
            _ -> do
                case checkGuessChar input list of
                    True -> do
                                remaining <- getGuessMax max (count-1) list
                                if(backspaceLast remaining) then
                                    return (removeFirst remaining) 
                                else
                                    return (toLower input: remaining)
                    False -> do
                                putChar '\b'
                                putChar '\b'
                                remaining <- getGuessMax max (count) list
                                return remaining

removeFirst :: [a] -> [a]
removeFirst [] = []
removeFirst (x:xs) = xs

backspaceLast :: [Char] -> Bool
backspaceLast (_: []) = False
backspaceLast ('\b': list) = True
backspaceLast _ = False

checkGuessChar :: Char -> String -> Bool 
checkGuessChar c "" = False 
checkGuessChar c (elem: string) = c==elem || checkGuessChar c string



-- Part D - gameplay
loop :: String -> [Char] -> Int -> Int -> IO()
loop word available maxAttempts attempts =
    do
        if(attempts > maxAttempts) then
            putStrLn (prompt Lose)
        else
            do
                putStrLn ("Attempt " ++ (show attempts))
                putStr (prompt Start)
                input <- getChar' 
                putStrLn ("")
                case input of 
                    'q' -> do
                            putStrLn (prompt Quit)
                    _ -> do
                        putStr (prompt Guess)
                        guess <- getGuess 5 available
                        putStrLn (leftMargin ++ showStatus (getStatuses (checkGuess guess word)))
                        if(winningCondition (getStatuses (checkGuess guess word))) then
                            putStrLn (prompt Win)
                        else
                            loop word (updateAvailable available (checkGuess guess word)) maxAttempts (attempts+1)


getStatuses :: [(Char, Status)] -> [Status]
getStatuses [] = []
getStatuses ((char, status): statuses) = status: getStatuses statuses

winningCondition :: [Status] -> Bool
winningCondition [] = True 
winningCondition (status:statuses) = (status==Here) && winningCondition statuses

go :: String -> IO()
go word = loop (map toLower word) "abcdefghijklmnopqrstuvwxyz" 6 1