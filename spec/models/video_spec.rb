require 'spec_helper'

describe Video do

  it {should belong_to(:category)}
  it {should validate_presence_of(:title)}
  it {should validate_presence_of(:description)}
  it {should have_many(:reviews), order: "created_at Desc"}

  describe "#search_by_title" do
    it "returns empty array if no videos match search" do
      Video.create(title: "Futurama", description: "a good video")
      expect(Video.search_by_title("Monk")).to eq([])
    end
    it "returns array with video that matches title" do
      Video.create(title: "Monk", description: "A video.")
      Video.create(title: "Futurama", description: "Another video")
      expect(Video.search_by_title("Monk")).to eq([Video.find_by(title: "Monk")])
    end
    it "returns one video that matches partial title" do
      Video.create(title: "Monk", description: "A good video")
      expect(Video.search_by_title("Mo")).to eq([Video.find_by(title: "Monk")])
    end
    it "returns all videos that match partial title, ordered DESC" do
      Video.create(title: "Monk", description: "A video!")
      Video.create(title: "Monkey Buisness", description: "Another video!")
      expect(Video.search_by_title("Mon")).to eq([Video.find_by(title: "Monkey Buisness"), Video.find_by(title: "Monk")])
    end
    it "returns an empty array for an empty search" do
      Video.create(title: "Monk", description: "A great video")
      expect(Video.search_by_title("")).to eq([])
    end
  end

end



