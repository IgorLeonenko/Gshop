class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
  before_action :set_categories, :set_cart

  private
    def set_categories
      @cat = Category.all.order(:number)
    end

    def render_404
      render :file => "public/404.html", :status => 404, :layout => false
    end

    def set_cart
      @cart = ::Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
      @cart = ::Cart.create
      session[:cart_id] = @cart.id
    end

end
