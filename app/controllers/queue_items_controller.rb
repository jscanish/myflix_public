class QueueItemsController < ApplicationController
  def index
    @queue_items = current_user.queue_items
  end
end


