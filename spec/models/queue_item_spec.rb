require 'spec_helper'

describe QueueItem do
  it { should belong_to(:user) }
  it { should belong_to(:video)}

  describe "#review_rating" do
    it "finds the proper video" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      review = Fabricate(:review, user: user, video: video, rating: 4)
      queue_item = Fabricate(:queue_item, video: video, user: user)
      expect(queue_item.video).to eq(video)
    end
    it "returns video rating if rating exists" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      review = Fabricate(:review, user: user, video: video, rating: 4)
      queue_item = Fabricate(:queue_item, video: video, user: user)
      expect(queue_item.review_rating).to eq(4)
    end
    it "returns 0 if no rating exists" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      queue_item = Fabricate(:queue_item, video: video, user: user)
      expect(queue_item.review_rating).to eq("0")
    end
  end

  describe "#category_name" do
    it "returns the video's category name" do
      user = Fabricate(:user)
      category = Fabricate(:category)
      video = Fabricate(:video, category: category)
      queue_item = Fabricate(:queue_item, video: video, user: user)
      expect(queue_item.category_name).to eq(video.category.name)
    end
  end

end
