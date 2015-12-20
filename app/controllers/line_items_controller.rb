class LineItemsController < ApplicationController

  def create
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product.id, product.price)

    if @line_item.save
      respond_to do |format|
        format.html { redirect_to cart_path, notice: 'Item added to cart!' }
        format.js
      end
    else
      respond_to do |format|
        format.html { redirect_to :back, alert: 'Not added! No more products availabel' }
        format.js
      end
    end
  end

  def destroy
    @line_item = LineItem.find(params[:id])
    if @line_item.quantity == 1 || params[:delete].present?
      @line_item.destroy
    else
      @line_item.update_attributes(quantity: @line_item.quantity -= 1)
    end
  end
end
