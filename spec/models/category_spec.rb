require 'spec_helper'

describe Category do

  it {should have_many(:videos)}

  it "saves itself" do
    category = Category.new(name: "Action Movies")
    category.save
    expect(Category.first).to eq(category)
  end

end
