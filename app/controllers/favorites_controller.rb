class FavoritesController < ApplicationController
  def create
    user=current_user
    @product=Product.find(params[:product_id])
    if Favorite.create(user_id: user.id,product_id:@product.id)

    else
      redirect_to root_url
    end
  end

  def destroy
    user=current_user
    @product=Product.find(params[:product_id])
    if favorite=Favorite.find_by(user_id: user.id,product_id:@product.id)
      favorite.delete
    else
      redirect_to root_url
    end
  end
end

