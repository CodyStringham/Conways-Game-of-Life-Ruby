class Game
  attr_accessor :grid

  LIVE = "🦄"
  DEAD = " "
  WIDTH = 68
  HEIGHT = 34

  def initialize
    @grid = empty_grid

    if ENV['MODE'] == 'spaceship'
      spaceship
    else
      @grid.each {|row|row.map! {|cell|rand(10) == 1 ? LIVE : DEAD}}
    end

    loop_cells
  end

  def empty_grid
    Array.new(HEIGHT){ Array.new(WIDTH) { DEAD } }
  end

  def print_grid
    system "clear"
    print grid.map{|row| row.join(" ")}.join("\n") + "\n"
  end

  def loop_cells
    print_grid
    new_grid = empty_grid

    grid.each_with_index do |row, row_index|
      row.each_with_index do |cell, cell_index|
        new_grid[row_index][cell_index] = find_friends(cell, row_index, cell_index)
      end
    end

    replace_grid(new_grid)
  end

  def find_friends(cell, row_index, cell_index)
    row_fix = true if (row_index + 1) == HEIGHT
    cell_fix = true if (cell_index + 1) == WIDTH

    friends = [
      grid[(row_index - 1)][(cell_index - 1)],
      grid[(row_index - 1)][(cell_index)],
      grid[(row_index - 1)][(cell_fix ? 0 : cell_index + 1)],
      grid[(row_index)][(cell_fix ? 0 : cell_index + 1)],
      grid[(row_fix ? 0 : row_index + 1)][(cell_fix ? 0 : cell_index + 1)],
      grid[(row_fix ? 0 : row_index + 1)][(cell_index)],
      grid[(row_fix ? 0 : row_index + 1)][(cell_index - 1)],
      grid[(row_index)][(cell_index - 1)]
    ].map{|x| x if x == LIVE}.compact

    if cell == LIVE
      friends.size.between?(2,3)
    else
      friends.size == 3
    end ? LIVE : DEAD
  end

  def replace_grid(new_grid)
    @grid = new_grid
    sleep 0.1
    loop_cells
  end

  # GAME PATTERNS
  def spaceship
    @grid[0][1] = LIVE
    @grid[1][2] = LIVE
    @grid[2][0] = LIVE
    @grid[2][1] = LIVE
    @grid[2][2] = LIVE
  end

end

Game.new
