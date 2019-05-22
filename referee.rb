class Referee
  class << self
    def winner
      user = User::users[0]
      dealer = User::users[1]
      user_amount = user.hand.real_amount_cards
      dealer_amount = dealer.hand.real_amount_cards

      winner =
        if user_amount > 21
          diler
        elsif dealer_amount > 21
          user
        elsif dealer_amount > user_amount
          diler
        elsif dealer_amount < user_amount
          user
        else dealer_amount == user_amount
          nil
        end
    end
  end
end
