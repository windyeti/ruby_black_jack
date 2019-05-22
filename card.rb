class Card
  attr_accessor :suit, :value, :amount

  def initialize(suit:, value:, amount:)
    @suit = suit
    @value = value
    @amount = amount
  end
end
