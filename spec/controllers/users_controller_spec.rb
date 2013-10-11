require 'spec_helper'

describe UsersController do
  describe "GET new" do
    it "sets @user variable" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe "GET show" do
    before do
      set_current_user
      @user = Fabricate(:user)
    end
    it "sets the @user variable" do
      get :show, id: @user.id
      expect(assigns(:user)).to eq(@user)
    end
    it_behaves_like "require_logged_in_user" do
      let(:action) { get :show, id: @user.id }
    end
  end

  describe "POST create" do
    context "with valid personal info and valid card" do
      before do
        charge = double(:charge, successful?: true)
        Stripe::Charge.stub(:create).and_return(charge)
        post :create, user: Fabricate.attributes_for(:user), stripeToken: '123423'
      end
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

    context "with valid personal info and declined card" do
      it "does not create a user" do
        charge = double(:charge, successful?: false, error_message: "There's a problem with your credit card." )
        StripeWrapper::Charge.stub(:create).and_return(charge)
        post :create, user: Fabricate.attributes_for(:user), stripeToken: '123423'
        expect(User.count).to eq(0)
      end
      it "renders the new template" do
        charge = double(:charge, successful?: false, error_message: "There's a problem with your credit card." )
        StripeWrapper::Charge.stub(:create).and_return(charge)
        post :create, user: Fabricate.attributes_for(:user), stripeToken: '123423'
        expect(response).to render_template :new
      end
      it "displays error message" do
        charge = double(:charge, successful?: false, error_message: "There's a problem with your credit card.")
        StripeWrapper::Charge.stub(:create).and_return(charge)
        post :create, user: Fabricate.attributes_for(:user), stripeToken: '123423'
        expect(flash[:error]).to_not be_blank
      end
    end


    it "makes the use follow the inviter" do
      user = Fabricate(:user)
      invite = Fabricate(:invite, inviter: user, invitee_email: 'joe@example.com')
      charge = double(:charge, successful?: true)
      Stripe::Charge.stub(:create).and_return(charge)
      post :create, user: { email: 'joe@example.com', full_name: 'joe', password: 'password' }, invite_token: invite.token
      joe = User.where(email: 'joe@example.com').first
      expect(joe.follows?(user)).to be_true
    end
    it "makes the inviter follow the user" do
      user = Fabricate(:user)
      invite = Fabricate(:invite, inviter: user, invitee_email: 'joe@example.com')
      charge = double(:charge, successful?: true)
      Stripe::Charge.stub(:create).and_return(charge)
      post :create, user: { email: 'joe@example.com', full_name: 'joe', password: 'password' }, invite_token: invite.token
      joe = User.where(email: 'joe@example.com').first
      expect(user.follows?(joe)).to be_true
    end
    it "expires the invitation when accepted" do
      user = Fabricate(:user)
      invite = Fabricate(:invite, inviter: user, invitee_email: 'joe@example.com')
      charge = double(:charge, successful?: true)
      Stripe::Charge.stub(:create).and_return(charge)
      post :create, user: { email: 'joe@example.com', full_name: 'joe', password: 'password' }, invite_token: invite.token
      joe = User.where(email: 'joe@example.com').first
      expect(Invite.first.token).to be_nil
    end

    context "email sending" do
      before do
        charge = double(:charge, successful?: true)
        Stripe::Charge.stub(:create).and_return(charge)
      end
      it "sends the email" do
        post :create, user: Fabricate.attributes_for(:user), stripeToken: '123453'
        ActionMailer::Base.deliveries.should_not be_empty
      end
      it "sends email to proper user" do
        post :create, user: Fabricate.attributes_for(:user), stripeToken: '123453'
        message = ActionMailer::Base.deliveries.last
        message.to.should == [User.first.email]
      end
      it "has the proper content" do
        post :create, user: Fabricate.attributes_for(:user), stripeToken: '123453'
        message = ActionMailer::Base.deliveries.last
        message.body.should include("Welcome to Myflix.com")
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
      it "does not attempt to charge credit card" do
        Stripe::Charge.should_not_receive(:create)
      end
    end
  end

  describe "GET new_with_invite_token" do
    it "renders the :new template" do
      invite = Fabricate(:invite)
      get :new_with_invite_token, token: invite.token
      expect(response).to render_template :new
    end
    it "sets @user with invitee email" do
      invite = Fabricate(:invite)
      get :new_with_invite_token, token: invite.token
      expect(assigns(:user).email).to eq(invite.invitee_email)
    end
    it "sets @invite_token variable" do
      invite = Fabricate(:invite)
      get :new_with_invite_token, token: invite.token
      expect(assigns(:invite_token)).to eq(invite.token)
    end
    it "redirects to expired token page for invalid tokens" do
      get :new_with_invite_token, token: 'adalkdsjfa'
      expect(response).to redirect_to expired_token_path
    end
  end
end
