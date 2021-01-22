require "pry"

class TicTacToe
  attr_accessor :board

  WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ]

  def initialize
    @board = Array.new(9, " ")
  end

  def display_board
    puts " #{self.board[0]} | #{self.board[1]} | #{self.board[2]} "
    puts "-----------"
    puts " #{self.board[3]} | #{self.board[4]} | #{self.board[5]} "
    puts "-----------"
    puts " #{self.board[6]} | #{self.board[7]} | #{self.board[8]} "
  end

  def input_to_index(input)
    input.to_i - 1
  end

  def move(index, player)
    self.board[index] = player
  end

  def position_taken?(index)
    self.board[index] != " "
  end

  def valid_move?(index)
    !self.position_taken?(index) && index.between?(0, 8)
  end

  def turn_count
    9 - self.board.count(" ")
  end

  def current_player
    self.turn_count.even? ? "X" : "O"
  end

  def turn
    flag = false
    while !flag
      print "Please enter a number (1-9): "
      input = gets.strip
      index = self.input_to_index(input)
      flag = self.valid_move?(index)
    end
    self.move(index, current_player)
    
    ### Using Recursion ###
    # print "Please enter a number (1-9):"
    # input = gets.strip
    # index = self.input_to_index(input)
    # if self.valid_move?(index)
    #   self.move(index, current_player)
    # else
    #   turn # <= RECURSION!!!
    # end
    
    self.display_board
  end

  def won?
    WIN_COMBINATIONS.any? { |winning_combo|
      return winning_combo if winning_combo.all? { |el| self.board[el] == "X" } || winning_combo.all? { |el| self.board[el] == "O" }
    }
  end

  def full?
    self.board.none?(" ")
  end

  def draw?
    !self.won? && self.full?
  end

  def over?
    self.won? || self.draw?
  end

  def winner
    self.board[self.won?[0]] if self.won?
    # if won?
    #   if current_player == "X"
    #     return "O"
    #   else
    #     return "X"
    #   end
    # end
  end

  def play
    puts "Let's play Tic-Tac-Toe!"
    self.display_board

    self.turn until self.over?
    # while !over?
    #   turn
    # end
    puts self.winner ? "Congratulations #{self.winner}!" : "Cat's Game!"
    # puts "Cat's Game!" if draw?
    # puts "Congratulations X!" if winner == "X"
    # puts "Congratulations O!" if winner == "O"
  end
end
