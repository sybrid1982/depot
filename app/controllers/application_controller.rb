class ApplicationController < ActionController::Base
  before_action :set_date_loaded
  before_action :authorize
  protect_from_forgery with: :exception



  private
  def set_date_loaded
    @date_loaded = Time.now
  end

  protected
  def authorize
    unless User.find_by(id: session[:user_id])
      redirect_to login_url, notice: "Please log in"
    end
  end
end
