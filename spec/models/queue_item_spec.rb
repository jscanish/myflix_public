require 'spec_helper'

describe QueueItem do
  it { should belong_to(:user) }
  it { should belong_to(:video) }
  it { should validate_numericality_of(:position) }

  before do
    @user = Fabricate(:user)
    @category = Fabricate(:category)
    @video = Fabricate(:video, category: @category)
    @review = Fabricate(:review, user: @user, video: @video, rating: 4)
    @queue_item = Fabricate(:queue_item, video: @video, user: @user)
  end
  describe "#rating" do
    it "finds the proper video" do
      expect(@queue_item.video).to eq(@video)
    end
    it "returns video rating if rating exists" do
      expect(@queue_item.rating).to eq(4)
    end
  end

  describe "#rating=" do
    it "changes the rating of review if review is present" do
      @queue_item.rating = 4
      expect(Review.first.rating).to eq(4)
    end
    it "clears rating if review is present" do
      @queue_item.rating = nil
      expect(Review.first.rating).to be_nil
    end
    it "creates review with proper rating if review is not present" do
      @queue_item.rating = 4
      expect(Review.first.rating).to eq(4)
    end
  end

  describe "#category_name" do
    it "returns the video's category name" do
      expect(@queue_item.category_name).to eq(@video.category.name)
    end
  end
end
