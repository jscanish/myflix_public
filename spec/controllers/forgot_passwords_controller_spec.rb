require 'spec_helper'

describe ForgotPasswordsController do
  describe "POST create" do
    context "with no email address" do
      before { post :create, email: "" }
      it "redirects to forgot password page" do
        expect(response).to redirect_to forgot_password_path
      end
      it "shows error message" do
        expect(flash[:error]).to_not be_blank
      end
    end

    context "with valid email address" do
      before do
        @user = Fabricate(:user, email: "josh@example.com")
        post :create, email: @user.email
      end
      it "redirects to forgot password confirmation page" do
        expect(response).to redirect_to forgot_password_confirmation_path
      end
      it "sends email to the proper email address" do
        expect(ActionMailer::Base.deliveries.last.to).to eq([@user.email])
      end
    end

    context "with invalid email address" do
      before do
        @user = Fabricate(:user, email: "josh@example.com")
        post :create, email: "frank@example.com"
      end
      it "redirects to forgot password page" do
        expect(response).to redirect_to forgot_password_path
      end
      it "shows error message" do
        expect(flash[:error]).to_not be_blank
      end
    end
  end
end
