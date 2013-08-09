require 'spec_helper'

describe Video do

  it {should belong_to(:category)}
  it {should validate_presence_of(:title)}
  it {should validate_presence_of(:description)}

  describe "#search_by_title" do
    it "returns empty array if no videos match search" do
      expect(Video.search_by_title("Monk")).to eq([])
    end
    it "returns array with video that matches title" do
      Video.create(title: "Monk", description: "A video.")
      expect(Video.search_by_title("Monk")).to eq([Video.find_by(title: "Monk")])
    end
    it "returns all videos that match partial title" do
      Video.create(title: "Monk", description: "A video!")
      Video.create(title: "Monkey Buisness", description: "Another video!")
      expect(Video.search_by_title("Mon")).to eq([Video.find_by(title: "Monk"), Video.find_by(title: "Monkey Buisness")])
    end
  end

end



