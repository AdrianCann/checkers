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

  attr_accessor :board, :color
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
    if get_slides.include?(destination)
      move!(destination)
    else
      raise "Illegal Move"
    end
    self.position
  end

  def move!(destination)
    board[destination], board[position], self.position = self, nil, destination
    king = true if king_me?
  end

  def jump!(destination)
    x = (self.position[0] + destination[0])/2 #DRY OUT
    y = (self.position[1] + destination[1])/2 #DRY OUT, HOW?
    board[[x,y]] = nil
    move!(destination)
    nil
  end

  def perform_jump(destination)
    if get_jumps.include?(destination)
      jump!(destination)
    else
      raise "Illegal JUMP"
    end
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

  def add_diff(diff, jump = false) #make easier to add
    if jump
      new_pos_y = self.position[0] + 2 * diff[0]
      new_pos_x = self.position[1] + 2 * diff[1]
    else
      new_pos_y = self.position[0] + diff[0]
      new_pos_x = self.position[1] + diff[1]
    end
    [new_pos_y, new_pos_x]
  end

  def get_slides
    slides = []
    self.move_diffs.each do |diff| #move diff gets correct color array of diffs
      possible_move = add_diff(diff)
      slides << possible_move if valid?(possible_move)
    end
    slides
  end

  def get_jumps
    jumps = []
    self.move_diffs.each do |diff| #position of piece to be jumped
      landing_position = add_diff(diff, true)
      jumped_pos = add_diff(diff, false)
      jumps << landing_position if valid_jump?(jumped_pos, landing_position)
    end
    jumps
  end

  def valid?(position) # valid slide
    position.each do |coordinate|
      return false unless coordinate.between?(0,7)
    end
    board[position].nil?
  end

  def valid_jump?(jumped_pos, landing_position) #should only need 1 argument
    #board(piece_to_jump_position) && board(piece_to_jump_position).color != self.color && valid?(landing_position)
    return false if board[jumped_pos].nil?
    return false if board[jumped_pos].color == self.color
    valid?(landing_position)
  end

  def king_me?
    if color == :R
      position.first == 0
    elsif color == :B
      position.first == 7
    end
  end
end
