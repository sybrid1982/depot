class Order < ApplicationRecord
  enum pay_type: {
    "Check"            => 0,
    "Credit card"      => 1,
    "Purchase order"   => 2
  }
  validates :name, :address, :email, presence: true
  validates :pay_type, inclusion: pay_types.keys
  validates :email, format: {
    with: %r{\.(com|co|edu|org|net)\Z}i,
    message: 'please enter a valid e-mail address'
  }
  has_many :line_items, dependent: :destroy

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

  def set_ship_time(date)
    self.ship_date = date
  end
end
