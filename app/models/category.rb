class Category < ActiveRecord::Base
  has_many :products

  validates_presence_of :title, :short_description, :description, :number, :image

  mount_uploader :image, CategoryImageUploader
end
