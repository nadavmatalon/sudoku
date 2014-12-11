#SUDOKU

[![Code Climate](https://codeclimate.com/github/nadavmatalon/sudoku/badges/gpa.svg)](https://codeclimate.com/github/nadavmatalon/sudoku)

## Table of Contents

* [Screenshots](#screenshots)
* [General Description](#general-description)
* [What is Soduko](#what-is-soduko)
* [How to Install and Run Locally](#how-to-install-and-run-locally)
* [Functional Description](#functional-description)
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

This app implements the back-end logic for the game of __Sudoku__.

It was written following the course at 
[Makers Academy](http://www.makersacademy.com/) 
as an exercise in buiding the back-end logic of an app with 
[Ruby 2.1](https://www.ruby-lang.org/en/) using
[TDD](http://en.wikipedia.org/wiki/Test-driven_development) 
methodology (tests written with [Rspec](http://rspec.info/)).

__Update (14.11.14)__ : I've re-written the app from scratch 
to generate a more cohesive and cleaner code.

__Update (11.12.14)__ : Another round of deep code &amp; tests refactoring, 
this time splitting the single original Grid class to __Game__ and __Puzzle__ classes, 
as well as adding two new modules: __PuzzleGenerator__ and __PuzzleSolver__.


##What is Soduko

For those who don't know it, Here's a brief description of the game:

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


##How to Install and Run Locally

To run the code in terminal, clone the repo locally and run:

```bash
$> cd sudoku
$> bundle install
$> irb
>> require './lib/game.rb'
```


##Functional Description

The app is built around two classes: __Game__ &amp; __Puzzle__, and two modules: 
__PuzzleGenerator__ and __PuzzleSolver__.

Using these classes &amp modules, the app can:

* Create a new game with a random Sudoku puzzle 
* Puzzles can be generated at a specified difficulty level (from very easy to very hard)
* Check if a puzzle is solved
* Solve any given puzzle (though please note that some solutions take time...)
* Upload a new puzzle to the game
* Print the grid's current state in the terminal

Here's a quick demo of running the main constructor &amp; methods of the app:

```bash
$> irb
>> require './lib/game.rb'
=> true
>> game = Game.new(1)
## The above method generate a new game with a very easy puzzle (difficulty level: 1)
>> game.puzzle_str
=> "092140607700285109035609800210008500369512748578406300053020961020001400080904270"
>> game.puzzle_solved?
=> false
>> game.solve_puzzle
=> true
>> game.puzzle_str
=> "892143657746285139135679824214738596369512748578496312453827961927361485681954273"
>> game.puzzle_solved?
=> true
>> game.new_puzzle(5)
## The above method uploads a very hard puzzle to the game (difficulty level: 5)
>> game.puzzle_str
=> "000000008000000000700000000000000000009000020000000100502800000000000000000006400"
>> game.solve_puzzle
=> true
>> game.puzzle_str
=> "123457698456189237798263514214375869389614725675928143542831976967542381831796452"
=> game.print_puzzle

 1 2 3 | 4 5 7 | 6 9 8 
 4 5 6 | 1 8 9 | 2 3 7 
 7 9 8 | 2 6 3 | 5 1 4 
 ---------------------
 2 1 4 | 3 7 5 | 8 6 9 
 3 8 9 | 6 1 4 | 7 2 5 
 6 7 5 | 9 2 8 | 1 4 3 
 ---------------------
 5 4 2 | 8 3 1 | 9 7 6 
 9 6 7 | 5 4 2 | 3 8 1 
 8 3 1 | 7 9 6 | 4 5 2 
```


##Testing

Tests were written with [Rspec](http://rspec.info/) (3.1.7).

To run the testing suite in terminal, clone the repo and run: 

```bash
$> ch sudoku
$> rspec
```

##License

<p>Released under the <a href="http://www.opensource.org/licenses/MIT">MIT license</a>.</p>
