require './lib/journey_log'

describe JourneyLog do

 it "tests that journey log has been created" do
   expect(subject.journey_class).to be_instance_of Journey
 end
end
