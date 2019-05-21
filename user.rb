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

  attr_accessor :coins, :hand

  def initialize(name)
    @name = name
    @coins = 100
    @hand = Hand.new
    validate!
    self.class.add_users(self)
  end

  def increment
    coins += 10
  end

  def decrement
    coins -= 10
  end

  def validate!
    raise EMPTY_NAME if @name == ''
  end

  private

  attr_reader :name
end