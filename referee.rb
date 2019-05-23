require_relative 'game_rules/game_rules'

class Referee
  include GameRules

  def winners(users)
    users = users.select do |user|
      user.hand.score <= BJ
    end

    users_amount = users.map { |user| user.hand.score }
    max_amount = users_amount.max
    users.select { |user| user.hand.score == max_amount }
  end
end
