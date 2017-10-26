require 'test_helper'

class CartTest < ActiveSupport::TestCase
  setup do
    @product1 = products(:one)
    @product2 = products(:two)
  end

  test "Adding two different products to cart makes cart size two" do
    @cart = carts(:bob_cart)
    @cart.add_product (@product1)
    assert_equal 1, @cart.line_items.size
    @cart.add_product (@product2)
    assert_equal 2, @cart.line_items.size
  end

  test "Adding two same products to cart makes cart size one" do
    @cart = carts(:steve_cart)
    @cart.add_product(@product1).save!
    @cart.add_product(@product1).save!
    assert_equal 1, @cart.line_items.size
  end

  test "Cart with multiple of same product has correct quantity of product" do
    @cart = carts(:steve_cart)
    multiple = 3
    multiple.times do
      @cart.add_product(@product1).save!
    end
    item = @cart.line_items.find_by_product_id(@product1.id)
    assert_equal multiple, item.quantity
  end
end
