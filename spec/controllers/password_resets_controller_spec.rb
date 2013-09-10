require 'spec_helper'

describe PasswordResetsController do
  describe "GET show" do
    it "renders reset template if token is valid" do
      user = Fabricate(:user)
      user.update_column(:token, "123")
      get :show, id: '123'
      expect(response).to render_template :show
    end
    it "redirects to expired token template if token is invalid" do
      get :show, id: '123'
      expect(response).to redirect_to expired_token_path
    end
    it "sets token" do
      user = Fabricate(:user)
      user.update_column(:token, "123")
      get :show, id: '123'
      expect(assigns(:token)).to eq('123')
    end
  end

  describe "POST create" do
    context "with valid token" do
      it "redirects to sign in page" do
        user = Fabricate(:user, password: "old_password")
        user.update_column(:token, "123")
        post :create, token: "123", password: "password"
        expect(response).to redirect_to login_path
      end
      it "updates user's password" do
        user = Fabricate(:user, password: "old_password")
        user.update_column(:token, "123")
        post :create, token: "123", password: "password"
        expect(user.reload.authenticate("password")).to be_true
      end
      it "sets flash success message" do
        user = Fabricate(:user, password: "old_password")
        user.update_column(:token, "123")
        post :create, token: "123", password: "password"
        expect(flash[:success]).to_not be_blank
      end
      it "regenerates user's token" do
        user = Fabricate(:user, password: "old_password")
        user.update_column(:token, "123")
        post :create, token: "123", password: "password"
        expect(user.reload.token).to_not eq("123")
      end
    end
    context "with invalid token" do
      it "redirects to expired token path" do
        post :create, token: "2123", password: "new_password"
        expect(response).to redirect_to expired_token_path
      end
    end
  end
end
