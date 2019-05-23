require_relative "hand"

class User
  EMPTY_NAME = "Name is empty!!!"

  class << self
    def users
      @users
    end

    def add_users(user)
      @users ||= []
      @users << user
    end
  end

  attr_accessor :coins, :hand, :name

  def initialize(name)
    @name = name
    @coins = 100
    @hand = Hand.new
    validate!
    self.class.add_users(self)
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
