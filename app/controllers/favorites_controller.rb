class FavoritesController < ApplicationController
  def create
    user=current_user
    product=Product.find(params[:product_id])
    if Favorite.create(user_id: user.id,product_id:product.id)
    redirect_to product_path(product)
    else
      redirect_to root_url
    end
  end

  def destroy
    user=current_user
    product=Product.find(params[:product_id])
    if favorite=Favorite.find_by(user_id: user.id,product_id:product.id)
      favorite.delete
      redirect_to product_path(product)
    else
      redirect_to root_url
    end
  end
end

