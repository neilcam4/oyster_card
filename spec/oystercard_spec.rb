require './lib/oystercard'

describe Oystercard do
  let(:default_top_up) { 10 }

  it 'new card provides default balance of 0' do
    expect(subject.balance).to eq 0
  end

  describe '#top_up' do
    it 'should add top up value to balance' do
      subject.top_up(default_top_up)
      expect(subject.balance).to eq default_top_up
    end

    it 'should raise error if balance would go over limit' do
      expect { subject.top_up(Oystercard::BALANCE_LIMIT + 1) }.to raise_error Oystercard::BalanceLimitExceeded
    end
  end

  describe '#deduct' do
    it 'should deduct amount from balance' do
      subject.top_up(default_top_up)
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
      subject.top_up(default_top_up)
      subject.touch_in
      expect(in_journey?).to be true
    end

    it 'should not be in journey after touching out' do
      subject.touch_out
      expect(in_journey?).to be false
    end

    it "should raise error if balance is < #{Oystercard::MIN_BALANCE}" do
      expect{ subject.touch_in }.to raise_error Oystercard::LowBalance
    end
  end
end
