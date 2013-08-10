class CategoriesController < ApplicationController

  def index
    if logged_in?
      @categories = Category.all
    else
      redirect_to root_path
    end
  end

  def show
    @category = Category.find(params[:id])
  end

end
