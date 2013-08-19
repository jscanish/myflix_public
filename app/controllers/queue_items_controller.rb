class QueueItemsController < ApplicationController
  before_action :require_user

  def index
    @queue_items = current_user.queue_items
  end

  def create
    @video = Video.find(params[:video_id])

    if already_in_queue?(current_user)
      redirect_to @video
      flash[:notice] = "That video is already in your queue"
    else
      @queue_item = @video.queue_items.create(user: current_user, position: queue_position)
      redirect_to @video
      flash[:notice] = "Video added to your queue!"
    end
  end

  def destroy
    @queue_item = QueueItem.find(params[:id])
    @queue_item.destroy
    reorder_queue_position(current_user)
    redirect_to my_queue_path
  end


  private

  def queue_position
    current_user.queue_items.count + 1
  end

  def reorder_queue_position(user)
    count = 1
    user.queue_items.each do |item|
      item.update(position: count)
      count += 1
    end
  end

  def already_in_queue?(user)
    user.queue_items.map {|item| item.video}.include?(@video)
  end
end


