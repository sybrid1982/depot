class StoreController < ApplicationController
  include CurrentCart
  skip_before_action :authorize
  before_action :set_cart
  def index
    @products = Product.order(:title)
    @count = session_counter
    @session_string = get_session_count
    session[:disabled_button] = false
  end
  def session_counter
    session[:counter] ||= 0
    session[:counter] += 1
  end
  def get_session_count
    if @count > 5
      session_string = "You have viewed this page #{@count} times."
    else
      session_string = ""
    end
  end
end
