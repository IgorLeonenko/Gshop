class Product < ActiveRecord::Base
  belongs_to :category
  has_many :line_items, dependent: :destroy

  validates_presence_of :title, :short_description, :description, :price, :category_id, :article, :quantity
  validates_numericality_of :quantity, less_than: 0, message: 'No more products avalable'

  mount_uploader :image, ProductImageUploader
end
