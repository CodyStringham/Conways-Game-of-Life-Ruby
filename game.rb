class Game

  # Uses constants for values that won't change
  LIVE = "🦄"
  DEAD = " "
  WIDTH = 68
  HEIGHT = 34

  def initialize
    # Sets our grid to a new empty grid (set by method below)
    @grid = empty_grid

    # Randomly fills our grid with live cells
    @grid.each do |row|
      # Map will construct our new array, we use map! to edit the @grid
      row.map! do |cell|
        if rand(10) == 1
          LIVE # Place a live cell
        else
          DEAD # Place a dead cell
        end
      end
    end

    # Single line implimentation
    # @grid.each {|row|row.map! {|cell|rand(10) == 1 ? LIVE : DEAD}}

    loop_cells #start the cycle
  end

  def empty_grid
    Array.new(HEIGHT) do
      # Creates an array with HEIGHT number of empty arrays
      Array.new(WIDTH) do
        # Fills each array with a dead cell WIDTH number of times
        DEAD
      end
    end

    # Single line implimentation
    # Array.new(HEIGHT){ Array.new(WIDTH) { DEAD } }
  end

  def print_grid # Prints our grid to the terminal
    system "clear" # Clears the terminal window

    # Joins cells in each row with an empty space
    rows = @grid.map do |row|
      row.join(" ")
    end

    # Print rows joined by a new line
    print rows.join("\n")

    # Single line implimentation
    # print @grid.map{|row| row.join(" ")}.join("\n")
  end

  def loop_cells
    print_grid # Start by printing the current grid
    new_grid = empty_grid # Set an empty grid (this will be the next life cycle)

    # Loop through every cell in every row
    @grid.each_with_index do |row, row_index|
      row.each_with_index do |cell, cell_index|

        # Find the cells friends
        friends = find_friends(row_index, cell_index)

        # Apply life or death rules
        if cell == LIVE
          state = friends.size.between?(2,3)
        else
          state = friends.size == 3
        end

        # Set cell in new_grid for the next cycle
        new_grid[row_index][cell_index] = state ? LIVE : DEAD

      end
    end

    # Replace grid and start over
    @grid = new_grid
    start_over
  end

  def find_friends(row_index, cell_index)

    # Ruby can reach backwards through arrays and start over at the end - but it cannot reach forwards. If we're going off the grid, start over at 0
    row_fix = true if (row_index + 1) == HEIGHT
    cell_fix = true if (cell_index + 1) == WIDTH
    # You'll see below I will use 0 if one of these values is truthy when checking cells to the upper right, right, lower right, lower, and lower left.

    # Check each neighbor, use 0 if we're reaching too far
    friends = [
      @grid[(row_index - 1)][(cell_index - 1)],
      @grid[(row_index - 1)][(cell_index)],
      @grid[(row_index - 1)][(cell_fix ? 0 : cell_index + 1)],
      @grid[(row_index)][(cell_fix ? 0 : cell_index + 1)],
      @grid[(row_fix ? 0 : row_index + 1)][(cell_fix ? 0 : cell_index + 1)],
      @grid[(row_fix ? 0 : row_index + 1)][(cell_index)],
      @grid[(row_fix ? 0 : row_index + 1)][(cell_index - 1)],
      @grid[(row_index)][(cell_index - 1)]
    ]

    # Maps live neighbors into an array, removes nil values
    friends.map! do |friend|
      friend if friend == LIVE
    end

    # return friends without nil values
    friends.compact

    # Single line implimentation
    # friends.map{|x| x if x == LIVE}.compact
  end

  def start_over
    sleep 0.1
    loop_cells
  end

end

# Start game when file is run
Game.new
