class ProductsController < ApplicationController
  
  before_action :set_product, only: [:index, :new,:show,:destroy,:delete]
  before_action :set_product_image, except: [:index, :new]
  
 
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
    product = Product.find(params[:id])
    product.destroy
  end

  def delete
    unless current_user.id == @product.seller_id
      redirect_to product_path(params[:id]),alert:"出品者のみ削除が行なえます"
    end
      
  end

  def destroy
    if @product.destroy
      redirect_to products_path
    end
  end

  def show
    @category = @product.category
  end
private
  def product_params
    params.require(:product).permit(:name, :profile, :price, :category_id, :condition_id, :sendingday_id, :prefecture_code_id, :postage_id, :sendingtype_id, product_images_attributes: [:url, :_destroy, :id[0]]).merge(seller_id: current_user.id)
  end

  def show
    @category = @product.category
  end


  private
  def product_params
    params.require(:product).permit(:name,:profile,:price,:size,:condition_id,:sendingday_id,:postage_id,:prefecture_code_id,:sendingtype_id,:deal_closed_day).merge(user_id:current_user.id,category_id:params[:product][:category_id],brand_id:params[:products][:brand_id],seller_id:params[:products][:seller_id],buyer_id:params[:product][:buyer_id])
  end
  def set_product
    @product = Product.find(params[:id])
  end

  def set_product_image
    @image = ProductImage.find(params[:id])
    @images = ProductImage.where(params[:id])
  end
end
  
