#SUDOKU

## Table of Contents

* [Screenshots](#screenshots)
* [General Description](#general-description)
* [Main App Functionality](#main-app-functionality)
* [Running in Terminal](#running-in-terminal)
* [Testing](#testing)
* [License](#license)


##Screenshots

<table>
	<tr>
		<td align="center" width="200px">
			<a href="https://raw.githubusercontent.com/nadavmatalon/sudoku/master/images/sudoku_1.jpg">
				<img src="images/sudoku_1.jpg" height="92px" />
				 Generating a Puzzle
			</a>
		</td>
		<td align="center" width="200px">
			<a href="https://raw.githubusercontent.com/nadavmatalon/sudoku/master/images/sudoku_2.jpg">
				<img src="images/sudoku_2.jpg" height="92px" />
				 Solving a Puzzle
			</a>
		</td>
		<td align="center" width="200px">
			<a href="https://raw.githubusercontent.com/nadavmatalon/sudoku/master/images/sudoku_3.jpg">
				<img src="images/sudoku_3.jpg" height="92px" />
				 Testing
			</a>
		</td>
	</tr>
</table>


##General Description

This code implements the basic logic for the game of 'Sudoku' in terminal.

It was written in Ruby according to TDD.

So what is Sodoku?

```
"Sudoku is a logic-based combinatorial number-placement puzzle. The objective is to fill 
a grid made of 9x9 `squares` (81 in total) with digits so that each `column`, each `row`, 
and each `box`* contains all of the digits from 1 to 9. The puzzle setter provides a 
partially completed grid, which may have a unique solution or several possible solutions."

* The grid contians 9 so-called 'boxes', that is 3x3 sub-grids within the general grid.
```

(Adapted from: [Wikipedia on Sudoku](http://en.wikipedia.org/wiki/Sudoku))


##Main App Functionality

The code offers the following main functions:
(see [] seciotn below for additional functionality):

* Creating a new Soduko grid (with or without an uploaded puzzle)
* Generating puzzles (with difficulty levels ranging from 'Very Easy' [1] to 'Very Hard' [5])
* Uploading a puzzle to the grid
* Printing the grid in terminal
* Generating a complete solution to the puzzle


##Running in Terminal

To run the code in terminal, run:

```bash
$ irb						// or 'pry' if you prefer (and have it installed)
$ require ./lib/sudoku.rb
```

After that, you can run the following commands:

```bash


```

##Testing

Tests were written with Rspec (3.0.4)

To run the tests in terminal: 

```bash
$ rspec
```

##License

<p>Released under the <a href="http://www.opensource.org/licenses/MIT">MIT license</a>.</p>
