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

  def fill_row(row, color)
    if row % 2 == 0
      @rows[row].each_with_index do |element, i|
        @rows[row][i] = Piece.new([row,i], self, color) unless i % 2 == 0
      end

    elsif row % 2 != 0
      @rows[row].each_with_index do |element, i|
        @rows[row][i] = Piece.new([row, i], self, color) unless (i+1) % 2 == 0
      end
    end

  end

  def fill_grid
    black_rows = [0,1,2]
    red_rows = [7,6,5]
    black_rows.each { |row| fill_row(row, :B) }
    red_rows.each { |row| fill_row(row, :R) }
  end

  def display
    @rows.each do |row|
      row.each do |piece|
        if piece.nil?
          print "| |"
        elsif piece.king
          print "|K#{piece.color}|"
        else
          print "|#{piece.color}|"
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
  KING = []
  RED = [[-1,-1],[-1, 1]]
  BLACK = [[1,1],[1,-1]] #forward right, forward left

  attr_accessor :moves, :board, :color
  attr_accessor :king, :position

  def initialize(position, board, color)
    @board = board
    @king = false
    @position = position
    @color = color
  end

  def inspect
    king ? "K#{color}" : "P#{color}"
  end

  def perform_slide(destination)

  end

  def perform_jump
    #remove piece from board

  end

  def move_diffs  #
    if self.king
      KING
    elsif self.color == :R
      RED
    else
      BLACK
    end
  end

  def add_diff(diff) #make easier to add
    new_pos_y = self.position[0] + diff[0]
    new_pos_x = self.position[1] + diff[1]
    [new_pos_y, new_pos_x]
  end

  def get_moves #need to call whenever I move?
    new_moves = []
    self.move_diffs.each do |diff| #move diff gets correct color array of diffs
      possible_move = add_diff(diff)
      new_moves << possible_move if valid?(possible_move)
    end
    moves = new_moves
  end

  def valid?(position) # valid slide
    board[position].nil?
  end
end
