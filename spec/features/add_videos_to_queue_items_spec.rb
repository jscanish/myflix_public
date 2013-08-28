require 'spec_helper'

feature "user adds videos to queue" do
  scenario "user adds and reorders videos in the queue" do
      josh = User.create(full_name: "Josh Scanish", email: "josh@example.com", password: "josh")
      comedies = Fabricate(:category, name: "comedies")
      monk = Fabricate(:video, title: "Monk", category: comedies, description: "A great show")
      south_park = Fabricate(:video, title: "South Park", category: comedies)

    #login to myflix
    visit '/login'
    fill_in "Email Address", with: "josh@example.com"
    fill_in "Password", with: "josh"
    click_button "Sign in"
    page.should have_content "comedies"

    #user clicks on monk video image
    find("a[href='/videos/#{monk.id}']").click
    page.should have_content "Monk"

    #click on +my queue button
    click_button "+ My Queue"
    page.should_not have_content "+ My Queue"


    #click on My Queue link
    click_link "My Queue"
    page.should have_content "Monk"

    #click link back to video
    click_link "Monk"
    page.should have_content "A great show"

    #back to home page
    visit home_path
    page.should have_content "comedies"

    #click on south park image
    find("a[href='/videos/#{south_park.id}']").click
    page.should have_content "South Park"

    #add south park to queue
    click_button "+ My Queue"
    page.should_not have_content "+ My Queue"

    #return to queue page
    click_link "My Queue"
    page.should have_content "South Park"

    #ensure proper ranking of queueitems
    QueueItem.first.video.should eq(monk)
    QueueItem.last.video.should eq(south_park)

    #reorder queue items

  end
end
