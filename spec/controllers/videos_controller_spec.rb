require 'spec_helper'

describe VideosController do
  describe "GET show" do
    context "authenticated users" do
      before do
        user = User.create(full_name: "josh scanish", email: "josh@example.com", password: "password")
        session[:user_id] = user.id
      end

      it "sets @video variable" do
        video = Video.create(title: "name", description: "hello there")
        get :show, id: video.id
        expect(assigns(Video.first)).to eq(video)
      end

      it "renders show template"
    end
  end
end
