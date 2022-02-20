module Helpers where
import Base
import Distribution.Simple.Program.HcPkg (list)

-- Part A - Helper functions

-- Maps a list of status data to a string describing the status of a guess to the user
showStatus :: [Status] -> String
showStatus [] = ""
showStatus (status : statuses) = 
    if(status == Here) then 'Y':' ': showStatus statuses
    else if (status == Nowhere) then '-':' ': showStatus statuses
    else if (status == Elsewhere (Just Before)) then '<':' ': showStatus statuses
    else if (status == Elsewhere (Just After)) then '>':' ': showStatus statuses
    else 'y':' ': showStatus statuses

-- Removes any character from the first input that is given a status of Nowhere in the second input
updateAvailable :: [Char] -> [(Char, Status)] -> [Char]
updateAvailable [] _ = []
updateAvailable _ [] = []
updateAvailable (c: charList) statusList = 
    if(containsChar c statusList) then updateAvailable charList statusList
    else c: updateAvailable charList statusList

-- Returns True if the char does exist in the list and has the status equal to Nowhere, false otherwise
containsChar :: Char -> [(Char, Status)] -> Bool 
containsChar c [] = False 
containsChar c ((value, status): list) = (c==value && status == Nowhere) || containsChar c list

-- Computes a string containing just spaces, whose length is that of the message corresponding to the Start prompt as output by the
-- prompt function in the Base module
leftMargin :: String
leftMargin = createSpaces (length (prompt Start))

-- Create a string of as many spaces as the input 
createSpaces :: Int -> String 
createSpaces 0 = ""
createSpaces x = if (x<0) then "" else ' ': createSpaces (x-1)
