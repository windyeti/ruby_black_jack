class Accountant
  class << self
    def plus_cash(user)
      user.increment
    end

    def subtract_cash(user)
      user.decrement
    end
  end
end
