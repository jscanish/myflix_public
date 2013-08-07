require 'spec_helper'

describe Video do

  it {should belong_to(:category)}
  it {should validate_presence_of(:title)}
  it {should validate_presence_of(:description)}

  it "saves itself" do
    video = Video.new(title: "Breaking Bad",
            description: "The story of Walter White (Bryan Cranston), a struggling high school chemistry teacher who is diagnosed with inoperable lung cancer at the beginning of the series. He turns to a life of crime, producing and selling methamphetamine with a former student.",
            small_cover_url: "breaking_bad",
            large_cover_url: "breaking_bad_large",
            category_id: 1)
    video.save
    Video.first.title.should == "Breaking Bad"
  end

end



