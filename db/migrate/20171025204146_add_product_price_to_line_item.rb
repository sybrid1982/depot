class AddProductPriceToLineItem < ActiveRecord::Migration[5.0]
  def up
    # first, we need to add a column to LineItem for prices
    add_column :line_items, :price, :decimal, precision: 8, scale: 2

    # so, we need to add the product price to each line item
    LineItem.all.each do |lineitem|
      lineitem.update_attribute :price, lineitem.product.price
    end
  end
  def down
    remove_column :line_items, :price
  end
end
