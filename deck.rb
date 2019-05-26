require_relative "card.rb"

class Deck
  SUITS = ['♠', '♥', '♦', '♣'].freeze
  RANKS = [*(2..10), 'J', 'K', 'Q', 'A'].freeze

  attr_reader :cards

  def initialize
    @cards = []
    create_cards
  end

  def create_cards
    SUITS.each do |suit|
      RANKS.each do |rank|
        @cards << Card.new(suit: suit, rank: rank)
      end
    end
    @cards.shuffle!
  end

  def give_card
    @cards.pop
  end
end
