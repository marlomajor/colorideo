class CartCategoriesController < ApplicationController
  def create
    @cart.add_category(params[:category_id])
    session[:cart] = @cart.contents
    redirect_to city_categories_path(params[:city_id])
  end

  def index
    @categories = []
    @total = 0
    @cart.contents.each do |category_id, count|
      category = Category.find(category_id)
      @categories << [category, count]
      @total += category.price * count
    end
  end

  def destroy
    @cart.remove(params[:category_id])
    category = Category.find(params[:category_id])
    flash[:notice] = "Successfully removed #{category.name} from your cart."
    redirect_to cart_path
  end
end
