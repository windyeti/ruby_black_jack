class Hand
  def initialize
    @cards = []
  end

  def cards
    @cards
  end

  def take_card(card)
    @cards << card
  end

  def real_amount_cards
    cards_sort = @cards.sort_by { |card| card[:amount] }
    cards_sort.inject(0) do |acc, card|
      card_value = card[:value]
      if acc + card[:amount] > 21 && card[:value] == "A"
        card_value = 1
      end
      acc + card_value
    end
  end
end
