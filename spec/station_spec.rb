require './lib/station'

describe Station do
  subject {described_class.new("Aldgate East", 1)}
  it "checks that station is created and has a name" do
    expect(subject.name).to eq ("Aldgate East")
  end

  it "checks that a station is made and a zone is created" do
    expect(subject.zone).to eq 1
  end
end
