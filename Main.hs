module Main where

import Base
import Helpers
import Core
import UserInterface
import GHC.Base (IO(IO))
import Data.Char
import Data.Binary.Get (remaining)
import GHC.IO.IOMode (IOMode(ReadMode))
import Control.Exception (handle)
import Data.Time (getCurrentTime)
import Text.XHtml (nowrap)
import Data.Time.Clock
import Data.Time.Calendar

-- Part E - stand-alone game, word list

readWords :: FilePath -> IO [String]
readWords = fmap lines . readFile

getCurrentDay :: IO Int
getCurrentDay = do
    now <- getCurrentTime
    let (year, month, day) = toGregorian $ utctDay now
    return day
    
getWordForDay :: [String] -> Int -> String 
getWordForDay words day = words!!day

main :: IO()
main = do 
    words <- readWords "wordlist.txt"
    day <- getCurrentDay 
    let word = getWordForDay words (day-1)
    go word
    