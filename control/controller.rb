require_relative "interface"
require_relative "../user"
require_relative "../dealer"
require_relative "../deck"
require_relative "../accountant"
require_relative "../referee"
require_relative "../game_rules/game_rules"

class Controller
  include GameRules

  def initialize
    @interface = Interface.new
    @accountant = Accountant.new
    @referee = Referee.new
  end
  def run
      @interface.show_message(Interface::QUESTION_NAME)
      name = @interface.input_string
      @user = User.new(name)
      @dealer = Dealer.new('Dealer')
      game
      @interface.show_message(Interface::BUY_BUY)
  end

  def game
    loop do
      @deck = Deck.new
      @accountant.create_bet([@user, @dealer])
      deal_two_cards([@user, @dealer])
      round
      @interface.show_message(Interface::RESULT_ROUND)
      @interface.show_result_round([@user, @dealer])
      winners = @referee.winners([@user, @dealer])
      @accountant.refund(winners)
      @interface.show_winner_round(winners, [@user, @dealer])
      if @user.coins < 10
        @interface.show_message(Interface::ALARM_NO_COINS)
        break
      end
      @interface.show_message(Interface::QUESTION_GAME)
      break if gets.chomp != ''
      clear_hand_cards([@user, @dealer])
    end
  end

  def round
    @user_open = false
    @user_pass = false
    @dealer_pass = false

    loop do
      break if check

      @interface.show_result_step_hide_dealer([@user, @dealer])

      user_action

      break if check

      dealer_action
    end
  end

  def check
    (@user_open) || \
    (@user_pass && @dealer_pass) || \
    (!@user.can_take_card? && !@dealer.can_take_card?) || \
    (@user_pass && !@dealer.can_take_card?) || \
    (@user.hand.score >= BJ || @dealer.hand.score >= BJ)
  end

  def user_action
    @interface.show_message(Interface::QUESTION_ACTION)
      action = @interface.input_fixnum
      if action == ACTION_TAKE_CARD
        @user.hand.take_card(@deck.give_card)
        @user_pass = false
      elsif action == ACTION_OPEN
        @user_open = true
      else
        @user_pass = true
      end
  end

  def dealer_action
    if @dealer.hand.score < MAX_DEALER_POINT
      @dealer.hand.take_card(@deck.give_card)
      @dealer_pass = false
    else
      @dealer_pass = true
    end
  end

  def clear_hand_cards(players)
    players.each { |user| user.hand.clear_cards }
  end

  def deal_two_cards(players)
    players.each do |user|
      2.times { user.hand.take_card(@deck.give_card) }
    end
  end
end
