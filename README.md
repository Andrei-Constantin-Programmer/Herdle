# Herdle

## What is Herdle?

Herdle is a Wordle clone created in Haskell. It was created for the Functional Programming module at the University of Kent.  
Wordle is a fun game in which you have a limited number of attempts to find a 5-letter word. You can check it out here: [Wordle](https://www.nytimes.com/games/wordle/index.html)  
Herdle is designed to emulate it, with some extra features too: you cannot use letters that have already been used (this is offset by the fact that you don't need to write real words as attempts) and the game tells you if a letter is in the right spot, in the wrong spot, to the right or to the left or nowhere at all.

---

# Install and Run

## Prerequisites
- The [GHC](https://www.haskell.org/downloads/) compiler

## How to install and run
1. Download the project as a ZIP from this link: https://github.com/Andrei-Constantin-Programmer/Herdle
2. Unzip the project at your desired location
3. Open the terminal on your computer
4. Go to the directory of your project using the 'cd' command
5. Run the 'ghci' command
6. In the 'ghci' prompt, run the ':load Main' command and wait for the files to compile
7. Run the 'main' command to play the game

## How to play
1. After running the 'main' command, you can follow the directions given by the game
2. Firstly, if you want to quit, you can simply input the 'q' letter, otherwise input any other character
3. You will then be prompted to enter your guess. This takes the form of 5 letters (do not use other characters). To delete the previous character, DO NOT use Backspace. Instead, input the '.' (full stop) character.
4. After inputting the five letters, the game will tell you the positions of the letters in the word, like so:
    - '-' means the letter does not exist in the word
    - 'Y' means the letter exists in the word at the same location
    - '>' means the letter exists in the word, but to the right of the current location
    - '<' means the letter exists in the word, but to the left of the current location
5. This goes on until the 6 attempts are over or until you have found the word (you can also choose the quit using [q] at the start of any attempt)

# Special thanks
1. My functional programming teacher, [Dominic Orchard](https://dorchard.github.io/) for teaching me Haskell and giving me the assignment
2. The development team behind Wordle for creating the original game
