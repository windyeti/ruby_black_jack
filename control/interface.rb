class Interface
  QUESTION_NAME = "Введите ваше имя:"
  RESULT_ROUND = "Результат раунда"
  ALARM_NO_COINS = "У одного из игроков нет денег для продолжения игры"
  QUESTION_GAME = "To repeat the game press 'Enter'. Type any other to exit"
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

  def show_result_step_hide_dealer(players)
    players = players.map do |player|
      player_cards = player.cards.map do |card|
        if player.name == "Dealer"
          " * "
        else
          "#{card.rank}#{card.suit}"
        end
      end

      player_value = player.score

      if player.name == "Dealer"
        "#{player.name} ==> #{player_cards.join(", ")}"
      else
        "#{player.name} ==> #{player_cards.join(", ")} : #{player_value}"
      end
    end
    puts "#{players.join(" || ")}"
  end

  def show_result_round(players)
    players = players.map do |player|
      player_cards = player.cards.map { |card| "#{card.rank}#{card.suit}" }
      player_value = player.score
      "#{player.name} ==> #{player_cards.join(", ")} : #{player_value}"
    end
    puts "#{players.join(" || ")}"
  end

  def show_winner_round(winners, players)
    result = winners.map do |user|
      "#{user.name} набрав #{user.score}. "
    end
    name_coins = winners.map do |user|
      "#{user.name} : #{user.coins}"
    end
    word_winner = winners.size < 2 ? "Победил" : "Победили"
    puts "#{word_winner}: #{result.join(" || ")}"
    puts "Общий результат: #{players.map { |player| "#{player.name} : #{player.coins}" }.join(" || ")}"
  end
end
