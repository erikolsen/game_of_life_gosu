require 'gosu'
require_relative 'game_of_life.rb'

class GameWindow < Gosu::Window
	def initialize(height=800, width=600)
		@height = height
		@width = width
		super height, width, false
		self.caption = "Game of Life"
		@backgroud_color = Gosu::Color.new(0xffdedede)
		@live_cell_color = Gosu::Color.new(0xff121212)
		@dead_cell_color = Gosu::Color.new(0xffdedede)

		@cols = width/10
		@rows = height/10

		@col_width = width/@cols
		@row_height = height/@rows

		@world = World.new(@cols, @rows)
		@game = Game.new(@world)
		@game.world.randomly_populate
	end

	def update
		@game.tick!
	end

	def draw
		draw_quad(0,0, @backgroud_color,
							width, 0, @backgroud_color,
							width, height, @backgroud_color,
							0, height, @backgroud_color)
		
		@game.world.cells.each do |cell|
			if cell.alive?
				draw_quad(cell.x * @col_width, cell.y * @row_height, @live_cell_color,
									cell.x * @col_width + @col_width, cell.y * @row_height, @live_cell_color,
									cell.x * @col_width + @col_width, cell.y * @row_height + @row_height, @live_cell_color,
									cell.x * @col_width, cell.y * @row_height + @row_height, @live_cell_color)
			else
				draw_quad(cell.x * @col_width, cell.y * @row_height, @dead_cell_color,
									cell.x * @col_width + @col_width, cell.y * @row_height, @dead_cell_color,
									cell.x * @col_width + @col_width, cell.y * @row_height + @row_height, @dead_cell_color,
									cell.x * @col_width, cell.y * @row_height + @row_height, @dead_cell_color)
			end
		end

	end

	def needs_cursor?
		true
	end
end


window = GameWindow.new
window.show

