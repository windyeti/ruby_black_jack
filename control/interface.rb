class Interface
  QUESTION_NAME = "Введите ваше имя:"
  RESULT_ROUND = "Результат раунда"
  ALARM_NO_COINS = "У вас нет денег для продолжения игры"
  QUESTION_GAME = "Continue the game? Press 'Enter'. Any other type to exit"
  BUY_BUY = "До новых встреч!"
  QUESTION_ACTION = "Выберите действие:"\
  " 0 - пас, 1 - еще карту, 2 - вскрываемся"

  def input_string
    gets.chomp
  end

  def input_fixnum
    gets.chomp.to_i
  end

  def show_message(message)
    puts message
  end

  def show_result_step_hide_dealer
    user = User::users[0]
    dealer = User::users[1]
    dealer_name = dealer.name
    dealer_cards = dealer.hand.cards.map { |card| " *" }.join(" ")
    user_name = user.name
    user_cards = user.hand.cards.map { |card| "#{card.value}#{card.suit}" }.join(", ")
    user_amount = user.hand.real_amount_cards
    puts "#{user_name} ==> #{user_cards} : #{user_amount} "\
    "|| #{dealer_cards} <== #{dealer_name}"
  end

  def show_result_step
    user = User::users[0]
    dealer = User::users[1]
    dealer_name = dealer.name
    dealer_cards = dealer.hand.cards.map { |card| "#{card.value}#{card.suit}" }.join(", ")
    dealer_amount = dealer.hand.real_amount_cards
    user_name = user.name
    user_cards = user.hand.cards.map { |card| "#{card.value}#{card.suit}" }.join(", ")
    user_amount = user.hand.real_amount_cards
    puts "#{user_name} ==> #{user_cards} : #{user_amount} "\
    "|| #{dealer_amount} : #{dealer_cards} <== #{dealer_name}"
  end

  def show_winner_round(winner)
    name_coins = User::users.map do |user|
      "#{user.name} : #{user.coins}"
    end
    if winner.nil?
      puts "Ничья"\
      "#{name_coins.join(" || ")}"
    else
      puts "Победил #{winner.name} набрав #{winner.hand.real_amount_cards}. "\
      "#{name_coins.join(" || ")}"
    end
  end
end
