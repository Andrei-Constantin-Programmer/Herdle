-- Part A - Helper functions
import Base

-- Maps a list of status data to a string describing the status of a guess to the user
showStatus :: [Status] -> String
showStatus [] = ""
showStatus (status : statuses) = 
    if(status == Here) then 'Y':' ': showStatus statuses
    else if (status == Nowhere) then '-':' ': showStatus statuses
    else if (status == Elsewhere (Just Before)) then '<':' ': showStatus statuses
    else if (status == Elsewhere (Just After)) then '>':' ': showStatus statuses
    else 'y':' ': showStatus statuses
