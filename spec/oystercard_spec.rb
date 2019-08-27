require './lib/oystercard'

describe Oystercard do
  it "new card provides default balance of 0" do
    expect(subject.balance).to eq 0
  end
end
