require_relative 'game_rules/game_rules'

class Referee
  def winners(user, dealer)
    if (user.score == dealer.score) || \
       (user.score > GameRules::BJ && \
       dealer.score > GameRules::BJ)
      [user, dealer]
    elsif user.score > GameRules::BJ
      [dealer]
    elsif dealer.score > GameRules::BJ
      [user]
    else
      user.score > dealer.score ? [user] : [dealer]
    end
  end
end
