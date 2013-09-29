require 'spec_helper'

describe Admin::VideosController do
  describe "GET new" do
    it_behaves_like "require_logged_in_user" do
      let(:action) { get :new }
    end
    it_behaves_like "require admin" do
      let(:action) { get :new }
    end
    it "sets instance variable to new video" do
      user = Fabricate(:user, admin: true)
      session[:user_id] = user.id
      get :new
      expect(assigns(:video)).to be_instance_of(Video)
    end
  end

  describe "POST create" do
    it_behaves_like "require_logged_in_user" do
      let(:action) { post :create }
    end
    it_behaves_like "require admin" do
      let(:action) { post :create }
    end

    context "with valid input" do
      before do
        @user = Fabricate(:user, admin: true)
        session[:user_id] = @user.id
        @category = Fabricate(:category)
        post :create, video: { title: "Monk", description: "something", category_id: @category.id }
      end
      it "redirects to the add video page" do
        expect(response).to redirect_to new_admin_video_path
      end
      it "creates the video" do
        expect(@category.videos.count).to eq(1)
      end
      it "flashes success message" do
        expect(flash[:success]).to_not be_blank
      end
    end

    context "with invalid input" do
      before do
        @user = Fabricate(:user, admin: true)
        session[:user_id] = @user.id
        @category = Fabricate(:category)
        post :create, video: { title: nil, description: "something", category_id: @category.id }
      end
      it "does not create the video" do
        expect(@category.videos.count).to eq(0)
      end
      it "renders the :new template" do
        expect(response).to render_template :new
      end
      it "sets the @video variable" do
        expect(assigns(:video)).to be_present
      end
      it "flashes error message" do
        expect(flash[:error]).to_not be_blank
      end
    end
  end
end
