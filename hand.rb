require_relative 'game_rules/game_rules'

class Hand
  include GameRules

  attr_reader :cards

  def initialize
    @cards = []
  end

  def take_card(card)
    @cards << card
  end

  def clear_cards
    @cards = []
  end

  def full?
    cards.size >= MAX_CARDS_HAND
  end

  def ace_correction(sum)
    if sum > BJ
      @cards.each { |card| sum -= ACE_CORRECTION if sum > BJ && card.ace? }
    end
    sum
  end

  def score
    sum = @cards.sum(&:value)
    ace_correction(sum)
  end
end
