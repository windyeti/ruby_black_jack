require_relative 'game_rules/game_rules'

class Dealer < User
  include GameRules

  def can_take_card?
    super && hand.score <= MAX_DEALER_POINT
  end
end
