class ProductsController < ApplicationController

  before_action :set_product, only: [:show]
 
  def index
    @products =Product.all
  end

  def new
  end

  def show
    @category = @product.category
  end

end

  private
  def set_product
    @product = Product.find(params[:id])
  end