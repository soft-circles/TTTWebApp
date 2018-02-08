require_relative '../game_controller'
require_relative '../board'
require_relative '../human'

RSpec.describe Game_Controller do
  let(:player1) { Human.new("X", true) }
  let(:player2) { Human.new("O") }
  let(:game) { Game_Controller.new(player1, player2) }

  it 'should instantiate a new game_controller without an error' do
    expect{ Game_Controller.new(player1, player2) }.not_to raise_error
  end

  it "player1 and player2 are player objects" do
    expect(game.player1).to be_a Player
    expect(game.player2).to be_a Player
  end

  it "board is a board object" do
    expect(game.board).to be_a Board
  end

  context "#players" do
    it "should return an array with 2 player objects" do
      expect(game.players).to eq([game.player1, game.player2])
    end

    it "should return the array in the order of who goes first" do
      game.player1.first = false
      game.player2.first = true
      expect(game.players).to eq([game.player2, game.player1])
      game.player1.first = true
      game.player2.first = false
      expect(game.players).to eq([game.player1, game.player2])
    end
  end

  context "#winner?" do
    it "should return true if there are 3 of the same symbol in any row" do
      game.board.spaces = ["X", "X", "X", 4, 5, 6, 7, 8, 9]
      expect(game.winner?).to eq(true)
      game.board.spaces = [1, 2, 3, "X", "X", "X", 7, 8, 9]
      expect(game.winner?).to eq(true)
      game.board.spaces = [1, 2, 3, 4, 5, 6, "X", "X", "X"]
      expect(game.winner?).to eq(true)
    end

    it "should return true if there are 3 of the same symbol in any column" do
      game.board.spaces = ["X", 2, 3, "X", 5, 6, "X", 8, 9]
      expect(game.winner?).to eq(true)
      game.board.spaces = [1, "X", 3, 4, "X", 6, 7, "X", 9]
      expect(game.winner?).to eq(true)
      game.board.spaces = [1, 2, "X", 4, 5, "X", 7, 8, "X"]
      expect(game.winner?).to eq(true)
    end

    it "should return true if there are 3 of the same symbol in a diagonal" do
      game.board.spaces = ["X", 2, 3, 4, "X", 6, 7, 8, "X"]
      expect(game.winner?).to eq(true)
      game.board.spaces = [1, 2, "X", 4, "X", 6, "X", 8, 9]
      expect(game.winner?).to eq(true)
    end

    it "should return false if there is not 3 of the same symbol on the board" do
      game.board.spaces = ["X", 2, 3, "O", "O", 6, 7, 8, "X"]
      expect(game.winner?).to eq(false)
    end

    it "should return false if there is a tie" do
      game.board.spaces = ["X", "X", "O", "O", "O", "X", "X", "O", "X"]
      expect(game.winner?).to eq(false)
    end
  end

  context "#tie?" do
    it "should return true if there is a tie" do
      game.board.spaces = ["X", "X", "O", "O", "O", "X", "X", "O", "X"]
      expect(game.tie?).to eq(true)
      game.board.spaces = ["O", "X", "O", "O", "X", "X", "X", "O", "O"]
      expect(game.tie?).to eq(true)
    end

    it "should return false if there are 3 in a row" do
      game.board.spaces = ["X", 2, 3, 4, "X", 6, 7, 8, "X"]
      expect(game.tie?).to eq(false)
      game.board.spaces = ["X", "O", "O", "O", "X", "O", "O", "O", "X"]
      expect(game.tie?).to eq(false)
    end

    it "should return false if there is not a tie" do
      game.board.spaces = ["O", 2, 3, 4, "X", 6, 7, 8, "X"]
      expect(game.tie?).to eq(false)
      game.board.spaces = [1, 2, 3, 4, 5, 6, 7, 8, 9]
      expect(game.tie?).to eq(false)
    end
  end

  context "#winner" do
    it "should return the winner's marker" do
      game.board.spaces = [1, 2, "X", 4, 5, "X", 7, 8, "X"]
      expect(game.winner).to eq("X")
    end
  end

  context "#game_type" do
    it "should return a string" do
      expect(game.game_type).to be_a String
    end

    it "should return HvH if both players are human" do
      expect(game.game_type).to eq "HvH"
    end

    it "should return HvC if one player is human and the other is computer" do
      player1 = Human.new("X", true)
      player2 = Computer.new("O")
      game = Game_Controller.new(player1, player2)
      expect(game.game_type).to eq "HvC"
    end

    it "should return CvC if both players are computers" do
      player1 = Computer.new("X")
      player2 = Computer.new("O")
      game = Game_Controller.new(player1, player2)
      expect(game.game_type).to eq "CvC"
    end
  end
end
