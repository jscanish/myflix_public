Fabricator(:following) do
  follower_id { [1,2,3,4,5].sample }
  followee_id { [1,2,3,4,5].sample }
end
