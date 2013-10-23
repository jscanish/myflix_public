class AdminsController < ApplicationController
  before_action :require_user

  def require_admin
    redirect_to root_path unless current_user.admin
  end


end
