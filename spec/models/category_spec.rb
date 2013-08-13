require 'spec_helper'

describe Category do
  it {should have_many(:videos)}

  describe "recent_videos" do
    it "shows all videos if total < 6" do
      Video.create(title: "Monk", description: "a good show", category_id: 1)
      Video.create(title: "Sherlock", description: "a great show", category_id: 1)
      Category.create(name: "Comedy")
      expect(Category.find(1).recent_videos).to eq([Video.find(2), Video.first])
    end
    it "shows only six most recent videos" do
      8.times{Video.create(title: "Monk", description: "a good show", category_id: 1)}
      Category.create(name: "Drama")
      expect(Category.find(1).recent_videos).to eq([Video.find(8), Video.find(7), Video.find(6), Video.find(5), Video.find(4), Video.find(3)])
    end
    it "returns empty array if category has no videos" do
      Category.create(name: "Action")
      expect(Category.find(1).recent_videos).to eq([])
    end
  end
end
