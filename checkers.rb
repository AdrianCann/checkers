class Board
  attr_accessor :rows

  def initialize # may want to do what was done in chess
    #(fill = true)
    create_grid
    #fill_grid
  end

  def create_grid
    @rows = Array.new(8) { Array.new(8) }
  end

  def fill_grid
    @rows.times do |row|

    end
  end

  def display
    @rows.each do |row|
      row.each do |piece|
        if piece.nil?
          print "| |"
        elsif piece.king
          print "|K|"
        else
          print "|C|"
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
  def initialize

  end

  def perform_slide

  end

  def perform_jump
    #remove piece from board
  end

  def move_diffs  #

  end
end
