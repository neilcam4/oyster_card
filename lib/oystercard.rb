class Oystercard
  class BalanceLimitExceeded < RuntimeError
  end

  attr_reader :balance

  BALANCE_LIMIT = 90

  def initialize(balance = 0)
    @balance = balance
    @in_journey = false
  end

  def top_up(amount)
    raise_if_balance_exceeded(amount)

    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end

  private

  def raise_if_balance_exceeded(amount)
    raise BalanceLimitExceeded if over_limit?(amount)
  end

  def over_limit?(amount)
    @balance + amount > BALANCE_LIMIT
  end
end
