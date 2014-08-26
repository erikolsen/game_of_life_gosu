class Game
  attr_accessor :world, :seeds
  
  def initialize(world=World.new, seeds=[])
    @world = world
    @seeds = seeds

    seeds.each do |seed|
      world.grid[seed[0]][seed[1]].alive = true
    end
  end

  def tick!
    next_itteration = check_rules
    update_grid(next_itteration)
  end

  def update_grid(next_itteration)
    world.cells.each_with_index do |cell, index| 
      cell.alive = next_itteration[index]
    end
  end

  def check_rules
    next_itteration = []
    world.cells.each do |cell|
      n = world.live_neighbors_around_cell(cell).size
      # rule 1
      if cell.alive? && n < 2
        next_itteration << false
      #rule 2
      elsif cell.alive? && (n == 2 || n == 3)
        next_itteration << true
      # rule 3
      elsif cell.alive? && n > 3
        next_itteration << false
      #rule 4
      elsif cell.dead? && n == 3
        next_itteration << true
      else
        next_itteration << cell.alive?
      end
    end
    return next_itteration
  end

end#game end


class World
  attr_accessor :rows, :cols, :grid, :cells

  def initialize(rows=3, cols=3)
    @rows = rows
    @cols = cols
    @cells = []
    @grid = Array.new(rows) do |row|
              Array.new(cols) do |col|
                cell = Cell.new(col, row)
                cells << cell
                cell
              end
            end
  end

  def live_neighbors_around_cell(cell)
    live_neighbors = []

    # Neighbour to the North-East
    if cell.y > 0 and cell.x < (cols - 1)
      candidate = self.grid[cell.y - 1][cell.x + 1]
      live_neighbors << candidate if candidate.alive?
    end
    # Neighbour to the South-East
    if cell.y < (rows - 1) and cell.x < (cols - 1)
      candidate = self.grid[cell.y + 1][cell.x + 1]
      live_neighbors << candidate if candidate.alive?
    end
    # Neighbours to the South-West
    if cell.y < (rows - 1) and cell.x > 0
      candidate = self.grid[cell.y + 1][cell.x - 1]
      live_neighbors << candidate if candidate.alive?
    end
    # Neighbours to the North-West
    if cell.y > 0 and cell.x > 0
      candidate = self.grid[cell.y - 1][cell.x - 1]
      live_neighbors << candidate if candidate.alive?
    end
    # Neighbour to the North
    if cell.y > 0
      candidate = self.grid[cell.y - 1][cell.x]
      live_neighbors << candidate if candidate.alive?
    end
    # Neighbour to the East
    if cell.x < (cols - 1)
      candidate = self.grid[cell.y][cell.x + 1]
      live_neighbors << candidate if candidate.alive? 
    end
    # Neighbour to the South
    if cell.y < (rows - 1)
      candidate = self.grid[cell.y + 1][cell.x]
      live_neighbors << candidate if candidate.alive?
    end
    # Neighbours to the West
    if cell.x > 0
      candidate = self.grid[cell.y][cell.x - 1]
      live_neighbors << candidate if candidate.alive?
    end
    return live_neighbors
  end

  def live_cells
    living_cells = []
    cells.each do |cell|
      living_cells << cell if cell.alive?
    end
    return living_cells
  end

  def randomly_populate
    cells.each do |cell|
      cell.alive = [true, false].sample
    end
  end

end

class Cell
  attr_accessor :alive, :x, :y

  def initialize(x=0, y=0)
    @alive = false
    @x = x
    @y = y
  end

  def die!
    @alive = false
  end

  def alive?
    alive
  end

  def dead?
    !alive
  end 

end