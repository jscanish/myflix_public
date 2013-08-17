class QueueItemsController < ApplicationController
  before_action :require_user
  def index
    @queue_items = current_user.queue_items
  end

  def create
    @video = Video.find(params[:video_id])

    if current_user.queue_items.map {|item| item.video}.include?(@video)
      redirect_to @video
      flash[:notice] = "That video is already in your queue"
    else
      @queue_item = @video.queue_items.create(user: current_user, position: queue_position)
      redirect_to my_queue_path
      flash[:notice] = "Video added to your queue!"
    end
  end

  def destroy

  end


  private

  def queue_position
    current_user.queue_items.count + 1
  end


end


