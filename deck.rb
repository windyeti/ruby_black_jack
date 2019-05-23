require_relative "card.rb"

class Deck
  SUITS = ['♠', '♥', '♦', '♣'].freeze
  RANKS = [*(2..10), 'J', 'K', 'Q', 'A'].freeze

  attr_reader :cards

  def initialize
    @cards = create_cards
  end

  def random
    @cards.random
  end

  def create_cards
    @cards = SUITS.map do |suit|
      RANKS.map do |rank|
        Card.new(suit: suit, rank: rank)
      end
    end
    @cards.flatten.shuffle
  end

  def give_card
    @cards.pop
  end
end
