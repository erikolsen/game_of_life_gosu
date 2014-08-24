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


  end

  context 'Cell' do
    subject { Cell.new }

    it 'should create a new cell' do
      expect(subject).to be_a(Cell)
    end

    it 'should respond to proper methods' do
      expect(subject).to respond_to(:alive)
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
        expectgame.tick!
        expect(world.grid[1][0]).to be_dead
        expect(world.grid[2][0]).to be_dead
      end

    end

  end






end






















