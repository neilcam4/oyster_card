class Oystercard
  class BalanceLimitExceeded < RuntimeError
  end

  class LowBalance < RuntimeError
  end

  attr_reader :balance, :entry_station, :journeys

  BALANCE_LIMIT = 90
  MIN_FARE      = 1

  def initialize(balance = 0)
    @balance = balance
    @journeys = []
  end

  def top_up(amount)
    raise_if_balance_exceeded(amount)

    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in(station)
    raise_if_insufficient_funds

    @entry_station = station
  end

  def touch_out(station)
    charge_min_fare
    @entry_station = nil
    @exit_station = station
    @journeys << {entry_station: @entry_station, exit_station: @exit_station}
  end

  def in_journey?
    @entry_station != nil
  end

  private

  def charge_min_fare
    @balance -= MIN_FARE
  end

  def raise_if_insufficient_funds
    raise LowBalance if insufficient_funds?
  end

  def insufficient_funds?
    @balance < MIN_FARE
  end

  def raise_if_balance_exceeded(amount)
    raise BalanceLimitExceeded if over_limit?(amount)
  end

  def over_limit?(amount)
    @balance + amount > BALANCE_LIMIT
  end
end
