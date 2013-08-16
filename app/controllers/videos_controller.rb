class VideosController < ApplicationController
  before_action :require_user
  def show
    @video = Video.find(params[:id])
    @reviews = @video.reviews
  end

  def search
    @videos = Video.search_by_title(params[:string])
  end
end

