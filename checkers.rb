class Board
  def intialize
    create_grid
    fill_grid
  end

  def create_grid
    @rows = Array.new(8) {Array.new}
  end

  def fill_grid
    @rows.each |row| do
      row.each do |square|
        #fill every other square
      end
    end
  end

  def display
    @rows.each |row| do
      rows.each do |piece|
        if piece.nil?
          print "| |"
        elsif piece.king
          print "| |"
        else
          print "|C|"
        end
      end
      puts
    end
    nil
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