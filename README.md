#SUDOKU

## Table of Contents

* [Screenshots](#screenshots)
* [General Description](#general-description)
* [What is Soduko](#what-is-soduko)
* [Functional Description](#functional-description)
* [How to Install and Run Locally](#how-to-install-and-run-locally)
* [Testing](#testing)
* [License](#license)


##Screenshots

<table>
	<tr>
		<td align="center" width="190px">
			<a href="https://raw.githubusercontent.com/nadavmatalon/sudoku/master/images/sudoku_1.jpg">
				<img src="images/sudoku_1.jpg" height="92px" /><br/>
				  A New Puzzle
			</a>
		</td>
		<td align="center" width="190px">
			<a href="https://raw.githubusercontent.com/nadavmatalon/sudoku/master/images/sudoku_2.jpg">
				<img src="images/sudoku_2.jpg" height="92px" /><br/>
				 Solving the Puzzle
			</a>
		</td>
		<td align="center" width="190px">
			<a href="https://raw.githubusercontent.com/nadavmatalon/sudoku/master/images/sudoku_3.jpg">
				<img src="images/sudoku_3.jpg" height="92px" /><br/>
				 Testing
			</a>
		</td>
	</tr>
</table>


##General Description

This app implements the logic for the game of __Sudoku__.

It was written in [Ruby](https://www.ruby-lang.org/en/) according to [TDD](http://en.wikipedia.org/wiki/Test-driven_development) using [Rspec](http://rspec.info/). 


##What is Soduko

Here's a brief description of the game:


>__Sudoku__ is a logic-based combinatorial number-placement puzzle. 
>
>The objective is to fill a grid made of 9x9 `squares` (81 in total) with digits  
>so that each `column`, each `row`, and each `box`* contains all of the digits 
>from 1 to 9. 
>
>The puzzle setter provides a partially completed grid, which may have a unique 
>solution or several possible solutions.
>
> \* The grid contians 9 so-called 'boxes', that is 3x3 sub-grids within the general grid.

(Source: [Wikipedia on Sudoku](http://en.wikipedia.org/wiki/Sudoku))


##Main Functionality

The code offers the following main UI functions:<br/>
(see the [How to Install and Run Locally](#how-to-install-and-run-locally) 
section below for a detailed account of the code's classes and methods):
* Creating a new Soduko grid (empty or with an uploaded puzzle)
* Generating new puzzles  - difficulty levels ranging from 'Very Easy' to 'Very Hard' (1-5)
* Uploading a puzzle to the grid
* Printing the grid in terminal
* Generating a complete solution for the puzzle


##How to Install and Run Locally

To run the code in terminal, clone the repo locally and run:

```bash
$> cd sudoku
$> irb
>> require './lib/sudoku.rb'
```

After that, you can use the following main constructors and methods for 
the __Grid__ and __PuzzleGenerator__ classes<br/> 
(additional supporting classes and methods can be found in the code itself):


###Grid Class

The Grid class contains the following `constructors` and `instance methods`:

| Constructor  | Description                                                      |
|----------|-----------------------------------------------------------------------|
| Grid.new | returns a new (empty) instance of a grid with 9x9 squares             |
| Grid.new(puzzle) | returns a new instance of a grid with a pre-loaded puzzle (see definition of a 'puzzle' below) | 

| Method  | Description                                                           |
|----------|-----------------------------------------------------------------------|
| .upload(puzzle) | uploads a puzzle to a grid instance                           |
| .solve   | generates a complete solution for the puzzle                          |
| .print_in_terminal  | prints the grid instace in the terminal                    |
| .current_state | returns a String with the current state of the grid (ie value of each square) |
| .fully_solved? | returns a boolean (true => grid is fully solved ; false => it's not) |
| .candidates_for(index) | returns an Array with possible solutions to a square at a given index (0-80) | 

* A `puzzle` is a String with 81 chars (each char must have value of 0-9).

Here are three example of `puzzles` you can use:

```ruby
easy_puzzle =   '015003002000100906270068430490002017501040380003905000900081040860070025037204600'

medium_puzzle = '000200001060075000057004060900000608000080000005630040500003000002000930708000014'

hard_puzzle =   '800000000003600000070090200050007000000045700000100030001000068008500010090000400'
```

###PuzzleGenerator Class

The PuzzleGenerator uses `class` methods to generate random puzzles.

Puzzles can be createsd with a difficulty level between 1-5 ('Very Easy' to 'Very Hard').

The default difficulty level if no argument is given is 3.

The level of difficulty is based on the number of empty squares (designated by the value 0)
in the puzzle (the more empty squares there are the harder the puzzle).

The PuzzleGenerator makes sure that every new puzzle is solvable.

To generate a new puzzle, run:

```ruby
> PuzzleGenerator::generate_puzzle
=> "600000400003000091041060230024093080000701000709020000000006009008279050000045800"

> PuzzleGenerator::generate_puzzle 1
=> "508013649423509087691740050007150000856000714000480500982075460715624003000891200"

> PuzzleGenerator::generate_puzzle 2
=> "005034078040207005061050300029083706536000480007005093000040509910500800050908042"

> PuzzleGenerator::generate_puzzle 3
=> "860007009052430008940006007230900005000005903509008001004090700000003010080000000"

> PuzzleGenerator::generate_puzzle 4
=> "006000000040008007050709000007000900000000050305000060070400000800000006004000079"

> PuzzleGenerator::generate_puzzle 5
=> "900010060000000000000000050010000000000000400300000800400070000000000000000000000"

```

##Testing

Tests were written with [Rspec](http://rspec.info/) (3.1.0).

To run the testing suite in terminal, clone the repo and run: 

```bash
$> ch sudoku
$> rspec
```

##License

<p>Released under the <a href="http://www.opensource.org/licenses/MIT">MIT license</a>.</p>

