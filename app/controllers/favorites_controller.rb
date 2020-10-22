class FavoritesController < ApplicationController
  before_action :set_product, only: %i[create destroy]


  def create
    user=current_user
    if Favorite.create(user_id: user.id,product_id:@product.id)

    else
      redirect_to root_url
    end
  end

  def destroy
    user=current_user
    if favorite=Favorite.find_by(user_id: user.id,product_id:@product.id)
      favorite.delete
    else
      redirect_to root_url
    end
  end

  private
  def set_product
    @product=Product.find(params[:product_id])
  end

end

