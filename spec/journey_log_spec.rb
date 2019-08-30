require './lib/journey_log'

describe JourneyLog do
let(:entry_station) { double :entry_station }
 it "tests that journey log has been created" do
   expect(subject.journey_class).to be_instance_of Journey
 end

 describe "#start" do
   it "starts a new journey with the entry station" do
     expect(subject.start).to eq entry_station
   end
 end
end
