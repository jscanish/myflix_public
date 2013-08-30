require 'spec_helper'

describe UsersController do
  describe "GET new" do
    it "sets @user variable" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe "GET show" do
    it "sets the @user variable" do
      set_current_user
      user = Fabricate(:user)
      get :show, id: user.id
      expect(assigns(:user)).to eq(user)
    end
    it_behaves_like "require_logged_in_user" do
      user = Fabricate(:user)
      let(:action) { get :show, id: user.id }
    end
  end

  describe "POST create" do
    context "with valid inputs" do
      before { post :create, user: Fabricate.attributes_for(:user) }
      it "creates the user" do
        expect(User.count).to eq(1)
      end
      it "starts a new session" do
        expect(session[:user_id]).to eq(User.first.id)
      end
      it "redirects to home path" do
        expect(response).to redirect_to home_path
      end
    end

    context "with invalid inputs" do
      before { post :create, user: Fabricate.attributes_for(:user, password: "hi") }
      it "does not create user when registration fails" do
        expect(User.count).to eq(0)
      end
      it "renders :new template when registration fails" do
        expect(response).to render_template :new
      end
      it "sets @user variable when registration fails" do
        expect(assigns(:user)).to be_instance_of(User)
      end
    end
  end
end
