require 'spec_helper'

describe ReviewsController do
  describe "POST create" do
    let(:video) { Fabricate(:video) }

    context "with authenticated users" do
      before { set_current_user }

      context "with valid credentials" do
        before do
          post :create, review: Fabricate.attributes_for(:review), video_id: video.id
        end
        it "redirects to current page" do
          expect(response).to redirect_to video
        end
        it "creates the review" do
          expect(Review.count).to eq(1)
        end
        it "associates review with proper video" do
          expect(Review.first.video).to eq(video)
        end
        it "associates review with current_user" do
          expect(Review.first.user).to eq(current_user)
        end
        it "flashes success message" do
          expect(flash[:notice]).to_not be_blank
        end
      end

      context "with invalid credentials" do
        it "does not create review" do
          post :create, review: Fabricate.attributes_for(:review, content: nil), video_id: video.id
          expect(video.reviews.count).to eq(0)
        end
        it "renders the video show template" do
          post :create, review: Fabricate.attributes_for(:review, content: nil), video_id: video.id
          expect(response).to render_template "videos/show"
        end
        it "sets @video variable" do
          post :create, review: Fabricate.attributes_for(:review, content: nil), video_id: video.id
          expect(assigns(:video)).to eq(video)
        end
        it "sets @review variable" do
          review = Fabricate(:review, video: video)
          post :create, review: {rating: 4}, video_id: video.id
          expect(assigns(:failed_review)).to match_array([review])
        end
      end
    end

    context "with unauthenticated users" do
      it_behaves_like "require_logged_in_user" do
        let(:action) { post :create, review: Fabricate.attributes_for(:review), video_id: video.id }
      end
    end
  end
end
