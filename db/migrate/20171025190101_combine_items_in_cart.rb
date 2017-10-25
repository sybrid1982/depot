class CombineItemsInCart < ActiveRecord::Migration[5.0]
  def up
    # replace multiple items for a single product with a single item with
    # a higher quantity
    Cart.all.each do |cart|
      sums = cart.line_items.group(:product_id).sum(:quantity)

      sums.each do |product_id, quantity|
        if quantity > 1
          # remove individual Items
          cart.line_items.where(product_id: product_id).delete_all

          # replace with a single line item
          item = cart.line_items.build(product_id: product_id)
          item.quantity = quantity
          item.save!
        end
      end
    end
  end

  def down
    # split single items with quantities greater than 1 into multiple line_items
    LineItem.where("quantity>1").each do |line_item|
      # Add individual items
      line_item.quantity.times do
        line_item.create( cart_id: line_item.cart_id,
                          product_id: line_item.product_id,
                          quantity: 1)

      end

      line_item.destroy
    end
  end
end
