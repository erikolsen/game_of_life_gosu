require 'rspec'
require_relative 'game_of_life.rb'


describe 'Game of life' do 
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
end