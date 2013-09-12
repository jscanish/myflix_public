Fabricator(:invite) do
  invitee_name { Faker::Name.name }
  invitee_email { Faker::Internet.email }
  message { Faker::Lorem.paragraph(1) }
end
