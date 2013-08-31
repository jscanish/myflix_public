class FollowingsController < ApplicationController

  def index
    @followings = current_user.follower_relationships
  end

end
