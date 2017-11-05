require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  test "ship date updates" do
    @time = Time.current
    @order = orders(:one)
    assert_nil(@order.ship_date)
    @order.set_ship_time(@time)
    assert_equal(@order.ship_date, @time)
  end
end
