class Interface
  QUESTION_NAME = "Введите ваше имя:"
  RESULT_ROUND = "Результат раунда"
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

  def show_result_step_hide_diler
    user = User::users[0]
    diler = User::users[1]
    diler_name = diler.name
    diler_cards = diler.hand.cards.map { |card| " *" }.join(" ")
    user_name = user.name
    user_cards = user.hand.cards.map { |card| "#{card.value}#{card.suit}" }.join(", ")
    user_amount = user.hand.real_amount_cards
    puts "#{user_name} ==> #{user_cards} : #{user_amount} "\
    "|| #{diler_cards} <== #{diler_name}"
  end

  def show_result_step
    user = User::users[0]
    diler = User::users[1]
    diler_name = diler.name
    diler_cards = diler.hand.cards.map { |card| "#{card.value}#{card.suit}" }.join(", ")
    diler_amount = diler.hand.real_amount_cards
    user_name = user.name
    user_cards = user.hand.cards.map { |card| "#{card.value}#{card.suit}" }.join(", ")
    user_amount = user.hand.real_amount_cards
    puts "#{user_name} ==> #{user_cards} : #{user_amount} "\
    "|| #{diler_amount} : #{diler_cards} <== #{diler_name}"
  end

  def show_winner_round(winner)
    name_coins = User::users.map do |user|
      "#{user.name} : #{user.coins}"
    end
    puts "Победил #{winner.name} набрав #{winner.hand.real_amount_cards}."\
    "#{name_coins.join(" || ")}"
  end
end
