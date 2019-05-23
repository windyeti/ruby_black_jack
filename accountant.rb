class Accountant
  def initialize
    @bet = 10
    @bank = 0
  end

  def create_bet(users)
    users.each do |user|
      withdraw(user)
      @bank += @bet
    end
  end

  def debit(user, coins)
    user.increment(coins)
  end

  def withdraw(user)
    user.decrement(@bet)
  end

  def refund(players)
    refund_amount = @bank / players.size
    players.each {|player| debit(player, refund_amount)}
    reset_bank
  end

  def reset_bank
    @bank = 0
  end
end
