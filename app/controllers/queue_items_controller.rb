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
    @queue_item.destroy if current_user.queue_items.include?(@queue_item)
    reorder_queue_position(current_user)
    redirect_to my_queue_path
  end

  def edit
    begin
      update_queue_items
    rescue ActiveRecord::RecordInvalid
      flash[:error] = "You must enter valid position numbers"
      redirect_to my_queue_path
      return
    end

    reorder_queue_position(current_user)
    redirect_to my_queue_path
  end


  private

  def queue_position
    current_user.queue_items.count + 1
  end

  def normalize_queue_position(user)

  end

  def reorder_queue_position(user)
    current_user.queue_items.each_with_index do |queue_item, index|
      queue_item.update_attributes(position: index+1)
    end
  end

  def update_queue_items
    ActiveRecord::Base.transaction do
      params[:queue_items].each do |queue_item_data|
        queue_item = QueueItem.find(queue_item_data["id"])
        queue_item.update_attributes!(position: queue_item_data["position"]) if queue_item.user == current_user
      end
    end
  end

  def already_in_queue?(user)
    user.queue_items.map {|item| item.video}.include?(@video)
  end
end


