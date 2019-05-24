require_relative 'game_rules/game_rules'

class Dealer < User
  def can_take_card?
    super && hand.score <= GameRules::MAX_DEALER_POINT
  end
end
