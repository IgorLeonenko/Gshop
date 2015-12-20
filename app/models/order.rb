class Order < ActiveRecord::Base
  STATUS = ['in process', 'aborted', 'completed']

  has_many :line_items, dependent: :destroy

  validates_presence_of :name, :last_name, :address, :email, :phone
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: true
  validates :phone, numericality: { only_integer: true }


  before_create :set_status
  after_create :set_product_quantity

  after_update :set_product_quantity

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

  def set_status
    self.status = STATUS[0]
  end

  def set_product_quantity
    if self.status == STATUS[0]
      self.line_items.each do |li|
        quantity = li.product.quantity - li.quantity
        li.product.update_attribute(:quantity, quantity)
      end
    elsif self.status == STATUS[1]
      self.line_items.each do |li|
        quantity = li.product.quantity + li.quantity
        li.product.update_attribute(:quantity, quantity)
      end
    end
  end
end
