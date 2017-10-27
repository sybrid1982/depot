class LineItem < ApplicationRecord
  after_save :destroy_empty

  belongs_to :product
  belongs_to :cart

  def total_price
    price * quantity
  end

  def decrement
    self.quantity -= 1
  end

  def destroy_empty
    if(self.quantity <= 0)
      self.destroy
    end
  end
end
