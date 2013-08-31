class FollowingsController < ApplicationController
  before_action :require_user

  def index
    @followings = current_user.follower_relationships
  end

  def create
    @following = Following.create(follower_id: current_user.id, followee_id: params[:followee_id])
    redirect_to people_path
  end

  def destroy
    @following = Following.find(params[:id])
    @following.destroy if @following.follower == current_user
    redirect_to people_path
  end

end
