class OrdersController < ApplicationController

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.add_line_items_from_cart(@cart)
    if @order.save
      Cart.destroy(session[:cart_id])
      session[:cart_id] = nil
      redirect_to root_path
      flash[:notice] = 'Thank\'s for order! Wait for operator call.'
    else
      flash.now[:alert] = 'Please, fill correctly required fields'
      render :new
    end
  end

  def destroy

  end

  private

    def order_params
      params.require(:order).permit(:name, :last_name, :address, :email, :phone)
    end  
end
