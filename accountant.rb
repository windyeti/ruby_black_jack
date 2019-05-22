class Accountant
  BET = 10
  @bank = 0

  class << self
    def create_bet
      User::users.each do |user|
        subtract_cash(user)
        @bank += BET
      end
    end

    def credit_winner(winner)
      if winner.nil?
        User::users.each do |user|
          plus_cash(user, BET)
        end
      else
        plus_cash(winner, @bank)
      end
      @bank = 0
    end

    def plus_cash(user, coins)
      user.increment(coins)
    end

    def subtract_cash(user)
      user.decrement(BET)
    end
  end
end
