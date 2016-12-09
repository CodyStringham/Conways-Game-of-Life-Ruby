class GameTricky
  attr_accessor :grid

  LIVE = "🦄"
  DEAD = " "
  WIDTH = 68
  HEIGHT = 34

  def initialize
    @grid = empty_grid
    if ENV['MODE'] == 'glider'
      glider
    elsif ENV['MODE'] == 'spaceship'
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
    print @grid.map{|row| row.join(" ")}.join("\n")
  end

  def loop_cells
    print_grid
    new_grid = empty_grid

    @grid.each_with_index do |row, row_index|
      row.each_with_index do |cell, cell_index|
        friends = find_friends(row_index, cell_index)

        state = if cell == LIVE
          friends.size.between?(2,3)
        else
          friends.size == 3
        end

        new_grid[row_index][cell_index] = state ? LIVE : DEAD
      end
    end

    replace_grid(new_grid)
  end

  def find_friends(row_index, cell_index)
    row_fix = true if (row_index + 1) == HEIGHT
    cell_fix = true if (cell_index + 1) == WIDTH
    [
      grid[(row_index - 1)][(cell_index - 1)],
      grid[(row_index - 1)][(cell_index)],
      grid[(row_index - 1)][(cell_fix ? 0 : cell_index + 1)],
      grid[(row_index)][(cell_fix ? 0 : cell_index + 1)],
      grid[(row_fix ? 0 : row_index + 1)][(cell_fix ? 0 : cell_index + 1)],
      grid[(row_fix ? 0 : row_index + 1)][(cell_index)],
      grid[(row_fix ? 0 : row_index + 1)][(cell_index - 1)],
      grid[(row_index)][(cell_index - 1)]
    ].map{|x| x if x == LIVE}.compact
  end

  def replace_grid(new_grid)
    @grid = new_grid
    sleep 0.1
    loop_cells
  end

  def glider
    @grid[0][1] = LIVE
    @grid[1][2] = LIVE
    @grid[2][0] = LIVE
    @grid[2][1] = LIVE
    @grid[2][2] = LIVE
  end

  def spaceship
    @grid[5][3] = LIVE
    @grid[5][4] = LIVE
    @grid[5][5] = LIVE
    @grid[5][6] = LIVE
    @grid[6][2] = LIVE
    @grid[6][6] = LIVE
    @grid[7][6] = LIVE
    @grid[8][2] = LIVE
    @grid[8][5] = LIVE
  end
end

GameTricky.new
