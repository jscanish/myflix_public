require 'spec_helper'

describe SessionsController do
  describe "GET new" do
    it "renders sign in page for unauthenticated users" do
      get :new
      expect(response).to render_template :new
    end
    it "redirects to home path if logged in" do
      set_current_user
      get :new
      expect(response).to redirect_to home_path
    end
  end

  describe "POST create" do
    let(:user) { Fabricate(:user) }
    context "with valid credentials" do
      before { post :create, email: user.email, password: user.password }

      it "creates new session with user" do
        expect(session[:user_id]).to eq(user.id)
      end
      it "redirects to home path" do
        expect(response).to redirect_to home_path
      end
      it "flashes messge" do
        expect(flash[:notice]).to_not be_blank
      end
    end

    context "with invalid credentials" do
      before { post :create, email: user.email, password: user.password + "hi" }

      it "does not create new session" do
        expect(session[:user_id]).to eq(nil)
      end
      it "flashes error message" do
        expect(flash[:error]).to_not be_blank
      end
      it_behaves_like "require_logged_in_user" do
        let(:action) { post :create, email: user.email, password: user.password + "hi" }
      end
    end
  end

  describe "GET destory" do
    before do
      set_current_user
      get :destroy
    end
    it "ends the session" do
      expect(session[:user_id]).to eq(nil)
    end
    it "redirects to root_path" do
      expect(response).to redirect_to root_path
    end
    it "flashes message" do
      expect(flash[:notice]).to_not be_blank
    end
  end
end
