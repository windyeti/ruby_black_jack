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
      @accountant.reward_winners(winners)
      @interface.show_winner_round(winners)
      @interface.show_money([@user, @dealer])
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

      @interface.show_card(@user)
      @interface.show_hidden_card(@dealer)

      action = user_action
      break if GameRules::USER_ACTIONS[action] == :open_cards

      break if round_end?

      dealer_action
    end
  end

  def round_end?
    !@user.can_take_card? && !@dealer.can_take_card?
  end

  def user_action
    action = 0
    loop do
      @interface.show_message(Interface::QUESTION_ACTION)
      action = @interface.input_fixnum
      break if (1..3).include?(action)

      @interface.show_message(Interface::WRONG_INDEX)
    end
    send(GameRules::USER_ACTIONS[action - 1])
  end

  def pass
    GameRules::ACTION_PASS
  end

  def take_card
    return unless @user.can_take_card?

    @user.take_card(@deck.give_card)
    GameRules::ACTION_TAKE_CARD
  end

  def open_cards
    GameRules::ACTION_OPEN
  end

  def dealer_action
    @dealer.take_card(@deck.give_card) if @dealer.can_take_card?
  end

  def clear_hand_cards
    [@user, @dealer].each(&:clear_cards)
  end

  def deal_two_cards
    [@user, @dealer].each do |user|
      2.times { user.take_card(@deck.give_card) }
    end
  end

  def users_have_enough_money?
    [@user, @dealer].all? { |user| user.coins >= GameRules::BET }
  end

  def repeat_game?
    gets.chomp == ''
  end
end
