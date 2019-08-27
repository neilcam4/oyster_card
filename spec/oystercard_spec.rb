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
end
