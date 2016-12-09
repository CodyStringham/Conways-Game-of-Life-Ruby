# Conways Game of Life in Ruby
The `game.rb` file was created in the most beginner way I know how, its meant to be extremely verbose and includes comments. There is another version called `game_tricky.rb` that includes more one-liners and silliness.

## Rules
- Any live cell with fewer than two live neighbours dies, as if caused by under-population.
- Any live cell with two or three live neighbours lives on to the next generation.
- Any live cell with more than three live neighbours dies, as if by over-population.
- Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

# Running the game
To run the game in your terminal, just type `rake`. For the best results you might want to change the `WIDTH` and `HEIGHT` constants in `game.rb` to fit your window.

# Advanced
The following commands will run the `game_tricky.rb` file with environment variables to set patterns.

#### Glider example
```
rake glider
```

#### Spaceship example
```
rake spaceship
```
