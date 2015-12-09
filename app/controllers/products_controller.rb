class ProductsController < ApplicationController
  def index
    @category = Category.find_by_number(params[:category]) if params[:category].present?
    @products = @category.present? ? @category.products.order(price: :desc) : Product.all
  end

  def show
    @product = Product.find(params[:id])
  end
end
