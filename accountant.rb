require_relative 'game_rules/game_rules'

class Accountant
  def create_bet(users)
    users.each do |user|
      withdraw(user)
      debit_bank
    end
  end

  def debit(user, coins)
    user.increment(coins)
  end

  def withdraw(user)
    user.decrement(GameRules::BET)
  end

  def reward_winners(players)
    refund_amount = @bank / players.size
    players.each {|player| debit(player, refund_amount)}
    reset_bank
  end

  def reset_bank
    @bank = 0
  end

  private

  def debit_bank
    @bank ||= 0
    @bank += GameRules::BET
  end
end
