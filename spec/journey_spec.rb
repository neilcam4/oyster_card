require './lib/journey'
require './lib/oystercard'

describe Journey do
  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }

  it 'should have an entry station' do
    expect(subject.start_journey(entry_station)).to eq entry_station
  end

  it 'should have an exit station' do
    expect(subject.finish_journey(exit_station)).to eq exit_station
  end

  describe '#fare' do
    it 'should return the minimum fare' do
      subject.start_journey(entry_station)
      subject.finish_journey(exit_station)
      expect(subject.fare).to eq Oystercard::MIN_FARE
    end

    it 'should return a penalty fare of 6' do
      expect(subject.fare).to eq Oystercard::PENALTY
    end
  end

  it 'checks if a journey is complete' do
    subject.start_journey(entry_station)
    expect(subject.journey_complete?).to eq false
  end
end