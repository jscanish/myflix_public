require 'spec_helper'

describe InvitesController do
  describe "GET new" do
    it "sets the instance variable" do
      set_current_user
      get :new
      expect(assigns(:invite)).to be_instance_of Invite
    end
    it_behaves_like "require_logged_in_user" do
      let(:action) { get :new }
    end
  end

  describe "POST create" do
    it_behaves_like "require_logged_in_user" do
      let(:action) { post :create }
    end
    context "with valid inputs" do
      after { ActionMailer::Base.deliveries.clear }
      before do
        set_current_user
        post :create, invite: Fabricate.attributes_for(:invite, invitee_email: 'hi@example.com')
      end
      it "redirects back to same page" do
        expect(response).to redirect_to new_invite_path
      end
      it "sets success message" do
        expect(flash[:success]).to_not be_blank
      end
      it "creates an invitation" do
        expect(Invite.all.count).to eq(1)
      end
      it "sends email to invitee" do
        expect(ActionMailer::Base.deliveries.last.to).to eq(['hi@example.com'])
      end
    end

    context "with invalid inputs" do
      before do
        set_current_user
      end
      it "should render new invite page" do
        post :create, invite: Fabricate.attributes_for(:invite, invitee_name: nil)
        expect(response).to render_template :new
      end
      it "should not create an invitation" do
        post :create, invite: Fabricate.attributes_for(:invite, invitee_name: nil)
        expect(Invite.all.count).to eq(0)
      end
      it "should not send an email" do
        post :create, invite: Fabricate.attributes_for(:invite, invitee_name: nil)
        expect(ActionMailer::Base.deliveries.count).to eq(0)
      end
      it "sets invite variable" do
        post :create, invite: Fabricate.attributes_for(:invite, invitee_name: nil)
        expect(assigns(:invite)).to be_present
      end
    end
  end
end
