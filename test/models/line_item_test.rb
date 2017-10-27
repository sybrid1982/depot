require 'test_helper'

class LineItemTest < ActiveSupport::TestCase
  test "decrement function decrements down" do
    @line_item = line_items(:one)
    @line_item.quantity = 2
    assert_equal(2, @line_item.quantity, "Failed to increase product number")
    @line_item.decrement
    assert_equal(1, @line_item.quantity, "Failed to decrease product number")
  end

  test "decrement function deletes quantity 0 object" do
    assert_difference 'LineItem.count', -1 do
      @line_item = line_items(:one)
      @line_item.quantity = 1
      @line_item.decrement
      @line_item.save!
    end
  end
end
