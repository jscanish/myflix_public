class CategoriesController < ApplicationController

  def index
    if params[:search_by_title]
      @videos = Video.search(params[:search_by_title])
    else
      @categories = Category.all
    end
  end

  def show
    @category = Category.find(params[:id])
  end

end
