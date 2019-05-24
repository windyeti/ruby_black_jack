require_relative 'game_rules/game_rules'

class Hand
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
    cards.size >= GameRules::MAX_CARDS_HAND
  end

  def score
    sum = @cards.sum(&:value)
    ace_correction(sum)
  end

  private

  def ace_correction(sum)
    if sum > GameRules::BJ
      @cards.each { |card| sum -= GameRules::ACE_CORRECTION if sum > GameRules::BJ && card.ace? }
    end
    sum
  end
end
