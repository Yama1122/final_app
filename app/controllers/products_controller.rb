class ProductsController < ApplicationController

  before_action :set_product, only: [:show]
 
  def index
    @products = Product.all
  end

  def new
    @product = Product.new
    @product.product_images.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save!
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @product.destroy
    redirect_to root_path
  end
private
  def product_params
    params.require(:product).permit(:name, :profile, :price, :category_id, :condition_id, :sendingday_id, :prefecture_code_id, :postage_id, :sendingtype_id, product_images_attributes: [:url])
  end

  def show
    @category = @product.category
  end

end

  private
  def set_product
    @product = Product.find(params[:id])
  end