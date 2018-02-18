class Board
  attr_reader :row_size
  attr_accessor :spaces

  def initialize(row_size = 3)
    raise InvalidBoardSize if row_size < 3
    @spaces = Array.new(row_size*row_size) { |i| i.to_i + 1 } 
    @row_size = row_size
  end

  def valid_spot?(spaces = @spaces, spot)
    spaces[spot - 1] == spot
  end

  def available_spaces(spaces = @spaces)
    spaces.reject { |space| space.is_a? String }
  end

  def unplayed?(spaces = @spaces)
      available_spaces(spaces).length == spaces.length 
  end

  def last_space
    available_spaces.length == 1 ? available_spaces[0] : nil
  end

  def empty_spaces(spaces = @spaces)
    spaces.count { |space| space.is_a? Integer }
  end

  def fill_spot(spaces = @spaces, spot, marker)
    spaces[spot - 1] = marker
    spaces
  end

  def reset_spot(spot)
    @spaces[spot - 1] = spot
  end

  def full?(spaces = @spaces)
    spaces.all? { |space| space.is_a? String } 
  end
end
