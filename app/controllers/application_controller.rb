class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :logged_in?, :already_in_queue?

  def current_user
    @current ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    unless logged_in?
      redirect_to login_path
    end
  end

  def already_in_queue?(user)
    user.queue_items.map {|item| item.video}.include?(@video)
  end


end
