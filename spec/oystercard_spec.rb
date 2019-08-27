require './lib/oystercard'

describe Oystercard do
  it 'new card provides default balance of 0' do
    expect(subject.balance).to eq 0
  end

  describe '#top_up' do
    it 'should add top up value to balance' do
      subject.top_up(10)
      expect(subject.balance).to eq 10
    end

    it 'should raise error if balance would go over limit' do
      expect { subject.top_up(Oystercard::BALANCE_LIMIT + 1) }.to raise_error Oystercard::BalanceLimitExceeded
    end
  end

  describe '#deduct' do
    it 'should deduct amount from balance' do
      subject.top_up(10)
      subject.deduct(5)
      expect(subject.balance).to eq 5
    end
  end

  describe 'journey progress' do
    def in_journey?
      subject.in_journey?
    end

    it 'should not be in journey by default' do
      expect(in_journey?).to be false
    end

    it 'should be in journey after touching in' do
      subject.touch_in
      expect(in_journey?).to be true
    end

    it 'should not be in journey after touching out' do
      subject.touch_out
      expect(in_journey?).to be false
    end
  end
end
