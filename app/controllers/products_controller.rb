class ProductsController < ApplicationController

  before_action :set_product, only: [:show]
  before_action :set_product_image
  
 
  def index
    @products =Product.all
  end

  def new
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
    @image = ProductImage.find_by(params[:id])
    @images = ProductImage.where(params[:id])
  end
end
  