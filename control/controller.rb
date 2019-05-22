require_relative "interface"
require_relative "../user"
require_relative "../deck"
require_relative "../accountant"
require_relative "../referee"

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
      Accountant::create_bet
      round
      @interface.show_message(Interface::RESULT_ROUND)
      @interface.show_result_step
      winner = Referee::winner
      Accountant::credit_winner(winner)
      @interface.show_winner_round(winner)
      puts "Do you wish play? Press 'Enter' If no type 'exit'"
      break if gets.chomp == 'exit'
    end
  end

  def round
    user_pass = false
    diler_pass = false

    loop do
      @interface.show_message(Interface::QUESTION_ACTION)
      action = @interface.input_fixnum
      if action == 1
        @user.hand.take_card(@deck.give_card)
        user_pass = false
      elsif action == 2
        break
      else
        user_pass = true
      end

      diler_action

      if (user_pass && diler_pass) || \
        (@user.hand.cards.size > 2 && @diler.hand.cards.size > 2) || \
        (user_pass && @diler.hand.real_amount_cards >= 17) || \
        (@user.hand.real_amount_cards >= 21 || @diler.hand.real_amount_cards >= 21)
        break
      end

      @interface.show_result_step_hide_diler

    end
  end

  def diler_action
    if @diler.hand.real_amount_cards < 17
      @diler.hand.take_card(@deck.give_card)
      diler_pass = false
    else
      diler_pass = true
    end
  end

end
