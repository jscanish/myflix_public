require 'spec_helper'

feature "user follows and unfollows other users" do
  scenario "user subscribes to another user, then removes them from people page" do
    josh = User.create(full_name: "Josh Scanish", email: "josh@example.com", password: "josh")
    jason = User.create(full_name: "Jason S", email: "jason@example.com", password: "jason")
    comedies = Fabricate(:category, name: "comedies")
    monk = Fabricate(:video, title: "Monk", category: comedies, description: "A great show")
    monk_review = Fabricate(:review, user_id: jason.id, video_id: monk.id)

    login(josh)
    expect(page).to have_content "Josh Scanish"

    find("a[href='/videos/#{monk.id}']").click
    expect(page).to have_content "Monk"

    click_link "#{jason.full_name}"
    expect(page).to have_content "Follow"

    click_link "Follow"
    expect(page).to have_content "People I Follow"
    expect(page).to have_content "#{jason.full_name}"

    click_on "remove_following_#{Following.first.id}"
    expect(page).to_not have_content "#{jason.full_name}"
  end
end
