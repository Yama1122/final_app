class ProductsController < ApplicationController
  before_action :set_product, only: :show
  def index 
  end

  def show
    @category = @product.category
  end

end

  private
  def set_product
    @product = Product.find(params[:id])
  end