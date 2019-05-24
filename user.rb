require_relative "hand"
require 'forwardable'

class User
  extend Forwardable

  EMPTY_NAME = "Name is empty!!!"

  attr_accessor :coins, :hand, :name
  def_delegators :hand, :score, :take_card, :cards, :clear_cards

  def initialize(name)
    @name = name
    @coins = 100
    @hand = Hand.new
    validate!
  end

  def can_take_card?
    !@hand.full?
  end

  def increment(value)
    @coins += value
  end

  def decrement(value)
    @coins -= value
  end

  def validate!
    raise EMPTY_NAME if @name == ''
  end
end
