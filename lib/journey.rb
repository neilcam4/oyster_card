class Journey
  attr_reader :entry_station

  def start_journey(entry_station)
    @entry_station = entry_station
  end

  def finish_journey(exit_station)
    @exit_station = exit_station
  end

  def fare
    return Oystercard::MIN_FARE if journey_complete?
    Oystercard::PENALTY
  end

  def journey_complete?
    @entry_station != nil && @exit_station != nil
  end
end