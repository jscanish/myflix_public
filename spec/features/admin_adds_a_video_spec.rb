require 'spec_helper'

feature "admin adds a video" do
  scenario "admin adds and watches a new video" do
    josh = Fabricate(:user, full_name: "Josh", email: "josh@example.ccom", admin: true)
    login(josh)
    expect(page).to have_content "Josh"

    visit '/admin/videos/new'
    expect(page).to have_content "Add a New Video"

    fill_in "Title", with: "A New Video"
    fill_in "Description", with: "A great video!"
    attach_file "Large cover", File.expand_path("public/tmp/monk_large.jpg")
    attach_file "Small cover", File.expand_path("public/tmp/monk.jpg")
    fill_in "Video URL", with: "http://www.youtube.com/watch?v=-yrZpTHBEss&list=TLQg2eLV1C5jrE7WS42chdAT4-gJ0rRBy6"
    click_button "Add Video"
    expect(page).to have_content "Video Added!"

    visit video_path(Video.first)
    expect(page).to have_selector("img[src='/uploads/monk_large.jpg']")
    expect(page).to have_selector("a[href='http://www.youtube.com/watch?v=-yrZpTHBEss&list=TLQg2eLV1C5jrE7WS42chdAT4-gJ0rRBy6']")
  end
end
