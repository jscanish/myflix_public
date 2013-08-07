require 'spec_helper'

describe Category do

  it {should have_many(:videos)}

  it "saves itself" do
    category = Category.new(name: "Action Movies")
    category.save
    Category.first.name.should == "Action Movies"
  end

end
