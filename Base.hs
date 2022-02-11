module Base where

-- Describe the status of each letter in the guess
data Status =
    Here                         -- Letter in correct place
  | Elsewhere (Maybe Direction)  -- Letter elsewhere in word, with optional direction
  | Nowhere                      -- Letter is not in the word
    deriving (Show, Eq)

-- Describe the position of a letter in a word
-- `Before` represents before and/or after
-- `After` represents strictly after
data Direction = Before | After
    deriving (Show, Eq)

-- Names of various prompts
data Prompt = Guess | Start | Quit | Lose | Win
    deriving (Show, Eq, Enum)

-- Give the string associated with the prompt
prompt :: Prompt -> String
prompt Lose  = "Run out of guesses!"
prompt Win   = "You got it. Well done!"
prompt Start = "Guess [any] or quit [q]? "
prompt Guess = "Ok. Enter your guess:    "
prompt Quit  = "Bye!"
