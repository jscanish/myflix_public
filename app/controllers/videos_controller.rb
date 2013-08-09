class VideosController < ApplicationController

  def show
    @video = Video.find(params[:id])
  end

  def search
    @videos = Video.search_by_title(params[:string])
  end
end

