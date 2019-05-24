require_relative "interface"
require_relative "../user"
require_relative "../dealer"
require_relative "../deck"
require_relative "../accountant"
require_relative "../referee"
require_relative "../game_rules/game_rules"

class Controller

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
      deal_two_cards
      round
      @interface.show_message(Interface::RESULT_ROUND)
      @interface.show_result_round([@user, @dealer])
      winners = @referee.winners(@user, @dealer)
      @accountant.refund(winners)
      @interface.show_winner_round(winners, [@user, @dealer])
      unless users_have_enough_money?
        @interface.show_message(Interface::ALARM_NO_COINS)
        break
      end
      @interface.show_message(Interface::QUESTION_GAME)
      break unless repeat_game?
      clear_hand_cards
    end
  end

  def round
    loop do
      break if round_end?

      @interface.show_result_step_hide_dealer([@user, @dealer])

      action = user_action
      break if GameRules::USER_ACTIONS[action] == :open_cards

      break if round_end?

      dealer_action
    end
  end

  def round_end?
    (!@user.can_take_card? && !@dealer.can_take_card?) ||\
    (@user.score >= 21 && @dealer.can_take_card?)
  end

  def user_action
    @interface.show_message(Interface::QUESTION_ACTION)
    action = @interface.input_fixnum
    send(GameRules::USER_ACTIONS[action])
  end

  def pass
    return GameRules::ACTION_PASS
  end

  def take_card
    @user.take_card(@deck.give_card)
    return GameRules::ACTION_TAKE_CARD
  end

  def open_cards
    return GameRules::ACTION_OPEN
  end

  def dealer_action
    if @dealer.score < GameRules::MAX_DEALER_POINT
      @dealer.take_card(@deck.give_card)
      @dealer_pass = false
    else
      @dealer_pass = true
    end
  end

  def clear_hand_cards
    ([@user, @dealer]).each { |user| user.clear_cards }
  end

  def deal_two_cards
    ([@user, @dealer]).each do |user|
      2.times { user.take_card(@deck.give_card) }
    end
  end

  def users_have_enough_money?
    ([@user, @dealer]).all? { |user| user.coins >= GameRules::BET }
  end

  def repeat_game?
    gets.chomp == ''
  end
end
