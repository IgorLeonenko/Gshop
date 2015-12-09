class PagesController < ApplicationController
  def home
    @categories = Category.all.order(:number)
  end
end
