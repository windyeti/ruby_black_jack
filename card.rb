require_relative 'game_rules/game_rules'

class Card
  SUITS = ['♠', '♥', '♦', '♣'].freeze
  RANKS = [*(2..10), 'J', 'K', 'Q', 'A'].freeze
  attr_accessor :suit, :rank, :value

  def initialize(suit:, rank:)
    @suit = suit
    @rank = rank
    @value = value_rank
  end

  def value_rank
    if %w[J Q K].include?(@rank)
      GameRules::FACE_VALUE
    elsif ace?
      GameRules::ACE_VALUE
    else
      @rank
    end
  end

  def ace?
    rank == 'A'
  end
end
