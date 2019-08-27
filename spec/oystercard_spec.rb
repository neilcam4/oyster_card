require './lib/oystercard'

describe Oystercard do
  let(:default_top_up) { 10 }

  def top_up_by_default_amount
    subject.top_up(default_top_up)
  end

  it 'new card provides default balance of 0' do
    expect(subject.balance).to eq 0
  end

  describe '#top_up' do
    it 'should add top up value to balance' do
      expect { top_up_by_default_amount }.to change { subject.balance }.by default_top_up
    end

    it 'should raise error if balance would go over limit' do
      expect { subject.top_up(Oystercard::BALANCE_LIMIT + 1) }.to raise_error Oystercard::BalanceLimitExceeded
    end
  end

  describe '#deduct' do
    it 'should deduct amount from balance' do
      top_up_by_default_amount
      expect { subject.deduct(5) }.to change { subject.balance }.by -5
    end
  end

  describe 'journey progress' do
    def in_journey?
      subject.in_journey?
    end

    it 'should not be in journey by default' do
      expect(in_journey?).to be false
    end

    describe '#touch_in' do
      it 'should be in journey after touching in' do
        top_up_by_default_amount
        subject.touch_in
        expect(in_journey?).to be true
      end

      it "should raise error if balance is < #{Oystercard::MIN_FARE}" do
        expect { subject.touch_in }.to raise_error Oystercard::LowBalance
      end
    end

    describe '#touch_out' do
      it 'should not be in journey after touching out' do
        subject.touch_out
        expect(in_journey?).to be false
      end

      it 'should reduce balance by minimum fare' do
        top_up_by_default_amount
        expect { subject.touch_out }.to change { subject.balance }.by -Oystercard::MIN_FARE
      end
    end
  end
end
