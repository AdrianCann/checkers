class Board
  attr_accessor :rows

  def initialize # may want to do what was done in chess
    #(fill = true)
    create_grid
    fill_grid
  end

  def create_grid
    @rows = Array.new(8) { Array.new(8) }
  end

  def fill_grid
    @rows[0].each_with_index do |element, i|
      @rows[0][i] = Piece.new([0,i], self) unless i % 2 == 0
    end
    #@rows[0].each_with_index

  end

  def display
    @rows.each do |row|
      row.each do |piece|
        if piece.nil?
          print "| |"
        elsif piece.king
          print "|K|"
        else
          print "|P|"
        end
      end
      puts
    end
    nil
  end

  def [](pos)
    # raise "Square not on board" unless valid?(pos) (write method)
    x,y = pos
    @rows[x][y]
  end

  def []=(pos, piece)

    x,y = pos
    @rows[x][y] = piece
  end

end

class Piece
  attr_reader :moves, :board
  attr_accessor :king, :position

  def initialize(position, board)
    @board = board
    @king = false
    @position = position
  end

  def inspect
    king ? "K" : "P"
  end

  def perform_slide

  end

  def perform_jump
    #remove piece from board
  end

  def move_diffs  #

  end
end
