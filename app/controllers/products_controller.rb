class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def new
    @product = Product.new
    @product.product_images.new
  end

  def create
    @products = Product.new(product_params)
    if @products.save!
      redirect_to root_path
    else
      redirect_to new_product_path
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
    params.require(:product).permit(:name, :price, :category, :condition, :sendingday, :brand, :postage, :sendingtype, product_images_attributes: [:url])
  end
end
