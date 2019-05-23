class Card
  attr_accessor :suit, :rank, :value

  def initialize(suit:, rank:)
    @suit = suit
    @rank = rank
    value_rank
  end

  def value_rank
    @value =
      if @rank.is_a?(Numeric)
        @rank
      elsif @rank == "J" || @rank == "Q" || @rank == "K"
        10
      else
        11
      end
  end

  def ace?
    rank == 'A'
  end
end
