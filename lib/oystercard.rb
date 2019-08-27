class Oystercard
  class BalanceLimitExceeded < RuntimeError
  end

  attr_reader :balance

  BALANCE_LIMIT = 90

  def initialize(balance = 0)
    @balance = balance
  end

  def top_up(amount)
    raise_if_balance_exceeded(amount)

    @balance += amount
  end

  private

  def raise_if_balance_exceeded(amount)
    raise BalanceLimitExceeded if over_limit?(amount)
  end

  def over_limit?(amount)
    @balance + amount > BALANCE_LIMIT
  end
end
