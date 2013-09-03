require 'spec_helper'

feature "user adds videos to queue" do
  scenario "user adds and reorders videos in the queue" do
    josh = User.create(full_name: "Josh Scanish", email: "josh@example.com", password: "josh")
    comedies = Fabricate(:category, name: "comedies")
    monk = Fabricate(:video, title: "Monk", category: comedies, description: "A great show")
    south_park = Fabricate(:video, title: "South Park", category: comedies, description: "A good show")

    #login to myflix
    login(josh)
    current_path.should == home_path
    page.should have_content "Josh Scanish"

    #user clicks on monk video image
    find("a[href='/videos/#{monk.id}']").click
    page.should have_content "Monk"

    #click on +my queue button
    click_button "+ My Queue"
    page.should_not have_content "+ My Queue"


    #click on My Queue link
    click_link "My Queue"
    current_path.should == my_queue_path

    #click link back to video
    click_link "Monk"
    page.should have_content "A great show"

    #back to home page
    visit home_path
    current_path.should == home_path

    #click on south park image
    find("a[href='/videos/#{south_park.id}']").click
    page.should have_content "South Park"

    #add south park to queue
    click_button "+ My Queue"
    page.should_not have_content "+ My Queue"

    #return to queue page
    click_link "My Queue"
    current_path.should == my_queue_path

    #ensure proper ranking of queueitems
    QueueItem.first.video.should eq(monk)
    QueueItem.last.video.should eq(south_park)

    #reorder queue items
    fill_in "video_#{monk.id}", with: 2
    fill_in "video_#{south_park.id}", with: 1
    click_button "Update Instant Queue"
    QueueItem.first.position.should eq(2)
    QueueItem.last.position.should eq(1)
  end
end
