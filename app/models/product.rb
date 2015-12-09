class Product < ActiveRecord::Base
  belongs_to :category

  validates_presence_of :title, :short_description, :description, :price, :category_id, :article, :quantity

  mount_uploader :image, ProductImageUploader
end
