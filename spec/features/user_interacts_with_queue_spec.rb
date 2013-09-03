require 'spec_helper'

feature "user adds and reorders videos in queue" do
  scenario "user adds and reorders videos in the queue" do
    josh = User.create(full_name: "Josh Scanish", email: "josh@example.com", password: "josh")
    comedies = Fabricate(:category, name: "comedies")
    monk = Fabricate(:video, title: "Monk", category: comedies, description: "A great show")
    south_park = Fabricate(:video, title: "South Park", category: comedies, description: "A good show")

    login(josh)
    page.should have_content "Josh Scanish"

    find("a[href='/videos/#{monk.id}']").click
    page.should have_content "Monk"

    click_button "+ My Queue"
    page.should_not have_content "+ My Queue"

    click_link "My Queue"
    current_path.should == my_queue_path

    click_link "Monk"
    page.should have_content "A great show"

    visit home_path
    find("a[href='/videos/#{south_park.id}']").click
    click_button "+ My Queue"
    click_link "My Queue"

    QueueItem.first.video.should eq(monk)
    QueueItem.last.video.should eq(south_park)

    fill_in "video_#{monk.id}", with: 2
    fill_in "video_#{south_park.id}", with: 1
    click_button "Update Instant Queue"
    QueueItem.first.position.should eq(2)
    QueueItem.last.position.should eq(1)
  end
end
