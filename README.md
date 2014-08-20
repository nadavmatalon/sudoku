#SUDOKU

## Table of Contents

* [Screenshots](#screenshots)
* [General Description](#general-description)
* [Main Functionality](#main-functionality)
* [Running in Terminal](#running-in-terminal)
* [Testing](#testing)
* [License](#license)


##Screenshots

<table>
	<tr>
		<td align="center" width="200px">
			<a href="https://raw.githubusercontent.com/nadavmatalon/sudoku/master/images/sudoku_1.jpg">
				<img src="images/sudoku_1.jpg" height="92px" />
				  A New Puzzle
			</a>
		</td>
		<td align="center" width="200px">
			<a href="https://raw.githubusercontent.com/nadavmatalon/sudoku/master/images/sudoku_2.jpg">
				<img src="images/sudoku_2.jpg" height="92px" />
				 Solving the Puzzle
			</a>
		</td>
		<td align="center" width="200px">
			<a href="https://raw.githubusercontent.com/nadavmatalon/sudoku/master/images/sudoku_3.jpg">
				<img src="images/sudoku_3.jpg" height="92px" />
				 Unit Testing
			</a>
		</td>
	</tr>
</table>


##General Description

This code implements the basic logic for the game of 'Sudoku' in terminal.

It was written in Ruby according to TDD.

So what is __Sodoku__?

```
Sudoku is a logic-based combinatorial number-placement puzzle. 

The objective is to fill a grid made of 9x9 `squares` (81 in total) with digits  
so that each `column`, each `row`, and each `box`* contains all of the digits 
from 1 to 9. 

The puzzle setter provides a partially completed grid, which may have a unique 
solution or several possible solutions.

* The grid contians 9 so-called 'boxes', that is 3x3 sub-grids within the general grid.
```

(Adapted from: [Wikipedia on Sudoku](http://en.wikipedia.org/wiki/Sudoku))


##Main Functionality

The code offers the following main functions:<br/>
(see the [Running in Terminal](#running-in-terminal) section below for a 
more detailed account of the code's functionality):
* Creating a new Soduko grid (with or without an uploaded puzzle)
* Generating new puzzles difficulty levels ranging from 'Very Easy' to 'Very Hard' (1-5)
* Uploading a puzzle to the grid
* Printing the grid in terminal
* Generating a complete solution for the puzzle


##Running in Terminal

To run the code in terminal, run:

```bash
$ irb
$ require './lib/sudoku.rb'
```

After that, you can use the following constructors and methods:<br/>
(additional supporting methods can be found in the code itself):

| Constructors  | Description                                                      |
|----------|-----------------------------------------------------------------------|
| Grid.new | returns a new (empty) instance of a grid with 9x9 squares             |
| Grid.new (puzzle)   | returns a new instance of a grid with a pre-loaded puzzle  |
|          | (see definition of a 'puzzle' below)                                  |

| Methods  | Description                                                           |
|----------|-----------------------------------------------------------------------|
| .upload (puzzle) | uploads a puzzle to a grid instance                           |
| .solve   | generates a complete solution for the puzzle                          |
| .print_in_terminal  | prints the grid instace in the terminal                    |
| .current_state | returns a String with the current state of the grid (ie value of each square) |
| .fully_solved? | returns a boolean (true => grid is fully solved ; false => it's not fully solved |
| .candidates_for (index) | returns an Array with possible solutions to a square at a given location (index => 0-80) | 
| .solve_square_in (index) | provides a solution to a square based on it's location (index => 0-80) |

* A `puzzle` is a String with 81 chars (each char must have value of 0-9).

Here are three example of `puzzle` you can use:

```ruby
easy_puzzle =   '015003002000100906270068430490002017501040380003905000900081040860070025037204600'

medium_puzzle = '000200001060075000057004060900000608000080000005630040500003000002000930708000014'

hard_puzzle =   '800000000003600000070090200050007000000045700000100030001000068008500010090000400'
```

##Testing

Tests were written with Rspec (3.0.4)

To run the tests in terminal: 

```bash
$ rspec
```

##License

<p>Released under the <a href="http://www.opensource.org/licenses/MIT">MIT license</a>.</p>
