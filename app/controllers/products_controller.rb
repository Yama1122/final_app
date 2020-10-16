class ProductsController < ApplicationController

  before_action :set_product, only: [:show,:destroy,:delete,:edit]
  before_action :set_product_image, except: [:index,:new,:create,:delete_done]
  
 
  def index
    @products = Product.all
  end

  def new
    @product = Product.new
    @product.product_images.new
  end

  def create
    @product = Product.new(product_params)
    # エラーハンドリング
    if @product.save
      redirect_to root_path, notice: '商品が出品されました。'
    else
      flash.now[:alert]= '必須項目を入力してください。'
      render :new
    end
  end

  def edit
    # editアクションで編集画面を表示させ、@productに画像を新規で追加させる
    @product.product_images.new
    @product = Product.find(params[:id])
    @category = @product.category
  end

  def update
    @product = Product.find(params[:id])
    @category = @product.category
    # エラーハンドリング
    if @product.update(product_params)
      redirect_to root_path, notice: '商品が編集されました。'
    else
      flash.now[:alert]= '必須項目を入力してください。'
      render :edit
    end
  end

  def delete
    unless current_user.id == @product.seller_id
      redirect_to product_path(params[:id]),alert:"出品者のみ削除が行なえます"
    end
  end

  def delete_done
  end

  def destroy
    if @product.destroy
      redirect_to  delete_done_product_path
    end
  end

  def show
    @category = @product.category
  end


  private
  def product_params
    params.require(:product).permit(:name, :profile, :price, :category_id, :condition_id, :sendingday_id, :prefecture_code_id, :postage_id, :sendingtype_id, product_images_attributes: [:url, :_destroy, :id]).merge(seller_id: current_user.id)
  end
  
  def set_product
    @product = Product.find(params[:id])
  end

  def set_product_image
    @image = ProductImage.find(params[:id])
    @images = ProductImage.where(params[:id])
  end
end
  
