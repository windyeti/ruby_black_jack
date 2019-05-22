class Referee
  class << self
    def winner
      user = User::users[0]
      diler = User::users[1]
      user_amount = user.hand.real_amount_cards
      diler_amount = diler.hand.real_amount_cards

      winner =
        if user_amount > 21
          diler
        elsif diler_amount > 21
          user
        elsif diler_amount > user_amount
          diler
        elsif diler_amount < user_amount
          user
        else diler_amount == user_amount
          nil
        end
    end
  end
end
