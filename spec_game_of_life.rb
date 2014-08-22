require 'rspec'
require_relative 'game_of_life.rb'


describe 'Game of life' do 
  context 'World' do
    subject { World.new }
    
    it "should create a new world object" do
      expect(subject).to be_a(World)
    end
    
    it 'should respond to proper methods' do
      expect(subject).to respond_to(:rows)
      expect(subject).to respond_to(:cols)
    end


  end
end