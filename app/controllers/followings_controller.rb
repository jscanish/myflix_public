class FollowingsController < ApplicationController
  before_action :require_user

  def index
    @followings = current_user.follower_relationships
  end

  def create
    followee = User.find(params[:followee_id])
    unless current_user.can_follow?(followee)
      redirect_to followee
    else
      Following.create(follower: current_user, followee_id: params[:followee_id])
      redirect_to people_path
    end
  end

  def destroy
    @following = Following.find(params[:id])
    @following.destroy if @following.follower == current_user
    redirect_to people_path
  end

end
