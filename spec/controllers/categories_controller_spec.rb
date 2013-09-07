require 'spec_helper'

describe CategoriesController do
  describe "GET index" do
    before do
      @comedy = Fabricate(:category, name: "comedy")
      @drama = Fabricate(:category, name: "drama")
    end
    it "sets @categories variable" do
      set_current_user
      get :index
      expect(assigns(:categories)).to match_array([@comedy, @drama])
    end
    it_behaves_like "require_logged_in_user" do
      let(:action) { get :index }
    end
  end

  describe "GET show" do
    before do
      @comedy = Fabricate(:category, name: "comedy")
      @drama = Fabricate(:category, name: "drama")
    end
    it "sets @category variable" do
      set_current_user
      get :show, id: @drama.id
      expect(assigns(:category)).to eq(@drama)
    end
    it_behaves_like "require_logged_in_user" do
      let(:action) { get :show, id: @drama.id }
    end
  end
end
