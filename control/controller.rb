require_relative "interface"
require_relative "../user"
require_relative "../deck"
require_relative "../accountant"

class Controller
  def initialize
    @interface = Interface.new
  end
  def run
      @deck = Deck.new
      @interface.show_message(Interface::QUESTION_NAME)
      name = @interface.input_string
      @user = User.new(name)
      @diler = User.new('Diler')
      game
  end

  def game
    loop do
      round
      # winner = refere
      # Accountant::(winner)
      puts "Do you wish play? Press 'Enter' If no type 'exit'"
      break if gets.chomp == 'exit'
    end
  end

  def round
    loop do
      @interface.show_message(Interface::QUESTION_ACTION)
      action = @interface.input_fixnum
      action(action)
      break if gets.chomp == "q"
      puts @deck.cards.size
      puts @user.hand.cards
      # if (User::users[0].hand.cards.size > 2 && User::users[1].hand.cards.size > 2) ||
    end
  end

  # QUESTION_ACTION = "Выберите действие:"\
  # " 0 - пас, 1 - еще карту, 2 - вскрываемся"

  def action(action)
    case action
    when 1 then
      p card = @deck.give_card
      @user.hand.take_card(card)
    # when 1 then @user.hand.take_card(@deck.give_card)
    end
  end
end
