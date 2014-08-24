class Game
  attr_accessor :world, :seeds
  
  def initialize(world=World.new, seeds=[])
    @world = world
    @seeds = seeds
  end

end

class World
  attr_accessor :rows, :cols, :grid

  def initialize(rows=100, cols=100)
    @rows = rows
    @cols = cols

    @grid = Array.new(rows) do |row|
              Array.new(cols) do |col|
                Cell.new(col, row)
              end
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

end