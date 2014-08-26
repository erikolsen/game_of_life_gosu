require 'rspec'
require_relative 'game_of_life.rb'

describe 'Game of life' do 
  
  let!(:world) { World.new }

  context 'World' do
    subject { World.new }
    
    it 'should create a new world object' do
      expect(subject).to be_a(World)
    end
    
    it 'should respond to proper methods' do
      expect(subject).to respond_to(:rows)
      expect(subject).to respond_to(:cols)
      expect(subject).to respond_to(:grid)
      expect(subject).to respond_to(:live_neighbors_around_cell)
    end

    it 'should create proper grid on initialization' do
      expect(subject.grid).to be_an Array
      subject.grid.each do |row|
        expect(row).to be_an(Array)
        row.each do |col|
          expect(col).to be_a(Cell)
        end
      end
    end

    it 'should add all cells to cells array' do 
      expect(subject.cells.count).to eq(9)
    end

    # [[0,0],[0,1],[0,2],
    #  [1,0],[1,1],[1,2],
    #  [2,0],[2,1],[2,2]]

    it 'should detect its northern neighbor' do
      expect(subject.grid[0][1]).to be_dead
      subject.grid[0][1].alive = true
      expect(subject.grid[0][1]).to be_alive
      expect(subject.live_neighbors_around_cell(subject.grid[1][1]).count).to eq(1)
    end

    it 'should detect its southern neighbor' do
      subject.grid[1][1].alive = true
      expect(subject.live_neighbors_around_cell(subject.grid[0][1]).count).to eq(1)
    end

    it 'should detect its eastern neighbor' do
      subject.grid[1][1].alive = true
      expect(subject.live_neighbors_around_cell(subject.grid[1][0]).count).to eq(1)
    end
    
    it 'should detect its western neighbor' do
      subject.grid[1][1].alive = true
      expect(subject.live_neighbors_around_cell(subject.grid[1][2]).count).to eq(1)
    end
    
    it 'should detect its north-western neighbor' do
      subject.grid[1][1].alive = true
      expect(subject.live_neighbors_around_cell(subject.grid[2][2]).count).to eq(1)
    end

    it 'should detect its north-eastern neighbor' do
      subject.grid[1][1].alive = true
      expect(subject.live_neighbors_around_cell(subject.grid[2][0]).count).to eq(1)
    end
    it 'should detect its south-eastern neighbor' do
      subject.grid[1][1].alive = true
      expect(subject.live_neighbors_around_cell(subject.grid[0][0]).count).to eq(1)
    end  
    
    it 'should detect its south-western neighbor' do
      subject.grid[1][1].alive = true
      expect(subject.live_neighbors_around_cell(subject.grid[0][2]).count).to eq(1)
    end

    it 'should detect multiplie neighbors' do 
      subject.grid[0][0].alive = true
      subject.grid[0][1].alive = true
      subject.grid[0][2].alive = true
      subject.grid[1][0].alive = true
      subject.grid[1][2].alive = true
      subject.grid[2][0].alive = true
      subject.grid[2][1].alive = true
      subject.grid[2][2].alive = true
      expect(subject.live_neighbors_around_cell(subject.grid[1][1]).count).to eq(8)

    end    
  end

  context 'Cell' do
    subject { Cell.new }

    it 'should create a new cell' do
      expect(subject).to be_a(Cell)
    end

    it 'should respond to proper methods' do
      expect(subject).to respond_to(:alive)
      expect(subject).to respond_to(:die!)
      expect(subject).to respond_to(:x)
      expect(subject).to respond_to(:y)
    end

    it 'should initialize properly' do
      expect(subject.alive).to be(false)
      expect(subject.x).to be(0)
      expect(subject.y).to be(0)
    end
  end

  context 'Game' do 
    subject { Game.new }
    
    it 'should create a new game object' do
      expect(subject).to be_a(Game)
    end

    it 'should respond to proper methods' do
      expect(subject).to respond_to(:world)
      expect(subject).to respond_to(:seeds)
    end 

    it 'should initialize properly' do
      expect(subject.world).to be_a(World)
      expect(subject.seeds).to be_a(Array)
    end

    it 'should plant seeds properly' do
      game = Game.new(world, [[1, 2], [0, 2]])
      expect(world.grid[1][2]).to be_alive
    end

  end

  context 'Rules' do 

    let!(:game) { Game.new }

    context 'Rule 1 Any live cell with fewer than two live neighbors dies, as if caused by under-population.' do
      
      it 'should kill a live cell with 1 live neighbor' do
        game = Game.new(world, [[1,0],[2,0]])
        game.tick!
        expect(world.grid[1][0]).to be_dead
        expect(world.grid[2][0]).to be_dead
      end

    end

    context 'Rule 2 Any live cell with two or three live neighbors lives on to the next generation.' do
      it 'should let cell live if it has two or three living neighbors' do 
        game = Game.new(world,[[0,0],[0,1],[0,2]])
        game.tick!
        expect(world.grid[0][1]).to be_alive
      end
    end

    context 'Rule 3 Any live cell with more than three live neighbors dies, as if by overcrowding.' do 
      it 'should kill a live cell with more than three neighbors' do 
        game = Game.new(world, [[0,0],[0,1],[0,2], [1,0], [1,1]])
        game.tick!
        expect(world.grid[1][1]).to be_dead
      end
    end

    context 'Rule 4 Any dead cell with exactly three live neighbors becomes a live cell, as if by reproduction.' do 
      it 'should awaken a dead cell if it has exactly three live neighbors' do 
        game = Game.new(world, [[0,0],[0,1],[0,2]])
        game.tick!
        expect(world.grid[1][1]).to be_alive
      end
    end

  end






end






















