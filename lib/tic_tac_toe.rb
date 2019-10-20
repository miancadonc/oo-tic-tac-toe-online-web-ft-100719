require 'pry'

class TicTacToe
  @board
  
  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]
    ]
    
  def initialize
    @board = Array.new(9, " ")
  end
  
  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} " 
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end
  
  def input_to_index(input)
    if [1,2,3,4,5,6,7,8,9].include?(input.to_i)
      choice = input.to_i
      choice -= 1 
    else
      nil
    end
  end
  
  def move(chosen_move, token = "X")
    @board[chosen_move] = token
  end
  
  def position_taken?(index)
      @board[index] == " " ? false : true
  end
  
  def valid_move?(index)
    if index == nil
      false
    elsif  @board[index] && self.position_taken?(index) == false
      true
    else
      false
    end
  end
  
  def turn
    puts "Please make your move by entering a number 1-9:"
    input = gets.chomp
    token = self.current_player
    index = self.input_to_index(input)
    if self.valid_move?(index)
      self.move(index, token)
      self.display_board
    else
      puts "That move is invalid."
      self.turn
    end
  end
  
  def turn_count
    @board.select{|space| space != " "}.count
  end
  
  def current_player
    self.turn_count.even? ? "X" : "O"
  end
  
  def won?
    WIN_COMBINATIONS.find do |combination|
      combination.all?{|space|@board[space] == "X"} || combination.all?{|space|@board[space] == "O"}
    end
  end
  
  def full?
    true unless @board.any?{|space| space == " "}
  end
  
  def draw?
    if self.full? && !self.won?
      true
    else
      false
    end
  end
  
  def over?
    true if self.won? || self.draw?
  end
  
  def winner
    if self.won?
      self.won?.all?{|space|@board[space] == "X"} ? "X" : "O"
    else
      nil
    end
  end
  
  def play
    self.turn until self.over?
    if self.won?
      puts "Congratulations #{self.winner}!"
    elsif self.draw?
      puts "Cat's Game!"
    else
      puts "I'm a bug!"
    end
  end
  
end