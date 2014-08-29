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
		@game = Game.new(@world,[[5, 1], [5, 2], [6, 1], [6, 2], [5, 11], 
														 [6, 11], [7, 11], [4, 12], [3, 13], [3, 14], 
														 [8, 12], [9, 13], [9, 14], [6, 15], [4, 16], 
														 [5, 17], [6, 17], [7, 17], [6, 18], [8, 16], 
														 [3, 21], [4, 21], [5, 21], [3, 22], [4, 22], 
														 [5, 22], [2, 23], [6, 23], [1, 25], [2, 25], 
														 [6, 25], [7, 25], [3, 35], [4, 35], [3, 36], [4, 36]])
		# @game.world.randomly_populate
		# @game.world[
		# 	(24, 8],, (22, 7), (24, 7),
	 #    (12, 6), (13, 6), (20, 6), (21, 6), (34, 6), (35, 6),
	 #    (11, 5), (15, 5), (20, 5), (21, 5), (34, 5), (35, 5),
	 #    (0, 4), (1, 4), (10, 4), (16, 4), (20, 4), (21, 4),
	 #    (0, 3), (1, 3), (10, 3), (14, 3), (16, 3), (17, 3), (22, 3), (24, 3),
	 #    (10, 2), (16, 2), (24, 2),
	 #    (11, 1), (15, 1),
	 #    (12, 0), (13, 0)
	 #    )
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
				#SHOW GRID
				# draw_quad(cell.x * @col_width, cell.y * @row_height, @live_cell_color,
				# 					cell.x * @col_width + (@col_width-1), cell.y * @row_height, @live_cell_color,
				# 					cell.x * @col_width + (@col_width-1), cell.y * @row_height + (@row_height-1), @live_cell_color,
				# 					cell.x * @col_width, cell.y * @row_height + (@row_height-1), @live_cell_color)
			else
				draw_quad(cell.x * @col_width, cell.y * @row_height, @dead_cell_color,
									cell.x * @col_width + @col_width, cell.y * @row_height, @dead_cell_color,
									cell.x * @col_width + @col_width, cell.y * @row_height + @row_height, @dead_cell_color,
									cell.x * @col_width, cell.y * @row_height + @row_height, @dead_cell_color)

				#SHOW GRID
				# draw_quad(cell.x * @col_width, cell.y * @row_height, @dead_cell_color,
				# 					cell.x * @col_width + (@col_width-1), cell.y * @row_height, @dead_cell_color,
				# 					cell.x * @col_width + (@col_width-1), cell.y * @row_height + (@row_height-1), @dead_cell_color,
				# 					cell.x * @col_width, cell.y * @row_height + (@row_height-1), @dead_cell_color)
			end
		end

	end

	def needs_cursor?
		true
	end
end


window = GameWindow.new
window.show

