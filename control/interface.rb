class Interface
  QUESTION_NAME = "Введите ваше имя:".freeze
  RESULT_ROUND = "Результат раунда".freeze
  ALARM_NO_COINS = "У одного из игроков нет денег для продолжения игры".freeze
  QUESTION_GAME = "To repeat the game press 'Enter'. "\
  "Type any other to exit".freeze
  BUY_BUY = "До новых встреч!".freeze
  WRONG_INDEX = "Некорректный ввод".freeze
  QUESTION_ACTION = "Выберите действие:"\
  " 1 - пас, 2 - еще карту, 3 - вскрываемся".freeze

  def input_string
    gets.chomp
  end

  def input_fixnum
    gets.chomp.to_i
  end

  def show_message(message)
    puts message
  end

  def show_hidden_card(player)
    cards = player.cards.map { " * " }.join(", ")
    puts "#{player.name} : #{cards}"
  end

  def show_card(player)
    value = player.cards.sum(&:value)
    cards = player.cards.map { |card| "#{card.rank}#{card.suit}" }.join(", ")
    puts "#{player.name} : #{cards} ==> #{value}"
  end

  def show_result_round(players)
    players = players.map do |player|
      player_cards = player.cards.map { |card| "#{card.rank}#{card.suit}" }
      player_value = player.score
      "#{player.name} : #{player_cards.join(", ")} ==> #{player_value}"
    end
    puts "#{players.join(" || ")}"
  end

  def show_winner_round(winners)
    result = winners.map do |user|
      "#{user.name} набрав #{user.score}. "
    end
    word_winner = winners.size < 2 ? "Победил" : "Победили"
    puts "#{word_winner}: #{result.join(" || ")}"
  end

  def show_money(players)
    result = players.map do |player|
      "#{player.name} : #{player.coins}"
    end
    puts "Общий результат: #{result.join(" || ")}"
  end
end
