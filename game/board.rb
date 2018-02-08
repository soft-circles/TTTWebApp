class Board
  attr_accessor :spaces
  attr_reader :last_move

  def initialize
    @spaces = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  def to_s
    " #{@spaces[0]} | #{@spaces[1]} | #{@spaces[2]} \n===+===+===\n #{@spaces[3]} | #{@spaces[4]} | #{@spaces[5]} \n===+===+===\n #{@spaces[6]} | #{@spaces[7]} | #{@spaces[8]} \n"
  end

  def valid_spot?(spot)
    @spaces[spot - 1] == spot
  end

  def available_spaces
    @spaces.reject { |space| space.is_a? String }
  end

  def unplayed?
    available_spaces.length == 9
  end

  def last_space
    available_spaces.length == 1 ? available_spaces[0] : nil
  end

  def empty_spaces
    @spaces.count { |space| space.is_a? Fixnum }
  end

  def fill_spot(spot, marker)
    if valid_spot?(spot)
      @spaces[spot - 1] = marker
      @last_move = {marker: @spaces[spot - 1], spot: spot}
      true
    end
    false
  end

  def reset_spot(spot)
    @spaces[spot - 1] = spot
  end
end
