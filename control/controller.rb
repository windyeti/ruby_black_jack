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
      @interface.show_message(Interface::QUESTION_NAME)
      name = @interface.input_string
      @user = User.new(name)
      @dealer = User.new('Dealer')
      game
      @interface.show_message(Interface::BUY_BUY)
  end

  def game
    loop do
      @deck = Deck.new
      Accountant::create_bet
      deal_two_cards
      round
      @interface.show_message(Interface::RESULT_ROUND)
      @interface.show_result_step
      winner = Referee::winner
      Accountant::credit_winner(winner)
      @interface.show_winner_round(winner)
      if @user.coins < 10
        @interface.show_message(Interface::ALARM_NO_COINS)
        break
      end
      @interface.show_message(Interface::QUESTION_GAME)
      break if gets.chomp != ''
      clear_hand_cards
    end
  end

  def round
    @user_open = false
    @user_pass = false
    @dealer_pass = false

    loop do
      break if check

      @interface.show_result_step_hide_dealer

      user_action

      break if check

      dealer_action
    end
  end

  def check
    (@user_open) || \
    (@user_pass && @dealer_pass) || \
    (@user.hand.cards.size > 2 && @dealer.hand.cards.size > 2) || \
    (@user_pass && @diler.hand.real_amount_cards >= 17) || \
    (@user.hand.real_amount_cards >= 21 || @dealer.hand.real_amount_cards >= 21)
  end

  def user_action
    @interface.show_message(Interface::QUESTION_ACTION)
      action = @interface.input_fixnum
      if action == 1
        @user.hand.take_card(@deck.give_card)
        @user_pass = false
      elsif action == 2
        @user_open = true
      else
        @user_pass = true
      end
  end

  def dealer_action
    if @dealer.hand.real_amount_cards < 17
      @dealer.hand.take_card(@deck.give_card)
      @dealer_pass = false
    else
      @dealer_pass = true
    end
  end

  def clear_hand_cards
    User::users.each { |user| user.hand.clear_cards }
  end

  def deal_two_cards
    User::users.each do |user|
      2.times { user.hand.take_card(@deck.give_card) }
    end
  end
end
