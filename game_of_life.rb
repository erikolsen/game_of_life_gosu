

class World
  attr_accessor :rows, :cols, :grid

  def initialize(rows=100, cols=100)
    @rows = rows
    @cols = cols

    @grid = Array.new(rows, Array.new(cols))

  end

end

class Cell
  
end