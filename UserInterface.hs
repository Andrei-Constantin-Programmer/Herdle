module UserInterface where

import Base
import Helpers
import Core
import GHC.Base (IO(IO))
import Data.Char
import Data.Binary.Get (remaining)
import GHC.IO.IOMode (IOMode(ReadMode))
import Control.Exception (handle)

-- Part C - receiving guesses

-- Read the guess and output it as a string
getGuess :: Int -> String -> IO String 
getGuess max list = getGuessMax max max list

-- Get guess with a known number of max characters
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

-- Remove the first element of the given list
removeFirst :: [a] -> [a]
removeFirst [] = []
removeFirst (x:xs) = xs

-- Check if the first element of the list is a backspace 
backspaceLast :: [Char] -> Bool
backspaceLast (_: []) = False
backspaceLast ('\b': list) = True
backspaceLast _ = False

-- Check if the given char is part of the given string
checkGuessChar :: Char -> String -> Bool 
checkGuessChar c "" = False 
checkGuessChar c (elem: string) = c==elem || checkGuessChar c string



-- Part D - gameplay

-- The gameplay loop
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

-- Get the list of statuses from the list of char-status touples
getStatuses :: [(Char, Status)] -> [Status]
getStatuses [] = []
getStatuses ((char, status): statuses) = status: getStatuses statuses

-- Check if the winning condition has been met
winningCondition :: [Status] -> Bool
winningCondition [] = True 
winningCondition (status:statuses) = (status==Here) && winningCondition statuses

-- Run the game with the given word
go :: String -> IO()
go word = loop (map toLower word) "abcdefghijklmnopqrstuvwxyz" 6 1
