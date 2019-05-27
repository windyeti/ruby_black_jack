require_relative "card.rb"

class Deck
  attr_reader :cards

  def initialize
    @cards = []
    create_cards
  end

  def create_cards
    Card::SUITS.each do |suit|
      Card::RANKS.each do |rank|
        @cards << Card.new(suit: suit, rank: rank)
      end
    end
    @cards.shuffle!
  end

  def give_card
    @cards.pop
  end
end
