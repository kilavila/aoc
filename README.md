# Advent of Code solutions in Lua

This is my solutions for the [Advent of Code](https://adventofcode.com).

### How-to

Add the puzzle input in an `input.txt` file, example: `event/2024/04/input.txt`.<br>
Or the small test input in an `input.test.txt` file.

Then run the solution or test the solution:

```
lua main.lua <mode> <year> <day> <part>
```

Mode:
- `run` will run the actual input
- `test` will run the small test input
- `new` will create files for a new event

Part:
- `1` or `2`, which puzzle part to run/test

Example:

```
lua main.lua run 2024 04 1
```

```
lua main.lua test 2024 04 1
```

```
lua main.lua new 2024 05
```

Alternatively create an alias for the script:

```
alias aoc='lua ~/path/to/main.lua'
```

And then you can run the following command from any directory:

```
aoc run 2024 04 1
```
