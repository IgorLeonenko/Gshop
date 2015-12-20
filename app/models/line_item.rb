class LineItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :product
  belongs_to :order

  before_create :ensure_product_quantity
  before_update :ensure_product_quantity

  def total_price
    price * quantity
  end

  def ensure_product_quantity
    if self.quantity <= self.product.quantity
      return true
    else
      return false
    end
  end

end
