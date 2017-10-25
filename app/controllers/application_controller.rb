class ApplicationController < ActionController::Base
  before_action :set_date_loaded
  protect_from_forgery with: :exception



  private
  def set_date_loaded
    @date_loaded = Time.now
  end
end
