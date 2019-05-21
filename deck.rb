require_relative "card.rb"

class Deck
  attr_reader :cards

  def initialize
    @cards = create_cards
  end

  def random
    @cards.random
  end

  def create_cards
    @cards = ["^", "-|-", "<>", "\/"].map do |suit|
      [2,3,4,5,6,7,8,9,10,"J","Q","K","A"].map do |value|
        amount =
          if value.is_a?(Numeric)
            value
          elsif value == "J" || value == "Q" || value == "K"
            10
          else
            11
          end
        Card.new(suit: suit, value: value, amount: amount)
      end
    end
    @cards.flatten
  end

  def delete_card(card)
    @card.delete(card)
  end

  def give_card
    card = @card.sample
    delete_card(card)
  end
end
