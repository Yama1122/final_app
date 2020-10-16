class UsersController < ApplicationController
  # before_action :set_user
  def show
    @user = current_user
    favorites = Favorite.where(user_id: current_user.id).pluck(:product_id) 
    @favorite_list = Product.find(favorites)  
    @products = Product.where(seller_id: current_user.id)
  end

  def logout
  end

  def registration_select
  end

  def complete
  end

  def myproducts
    @products = Product.where(seller_id: current_user.id)
  end

  def sold_myproducts
    @products = Product.where(seller_id: current_user.id)
  end

  def buy_myproducts
    @products = Product.where(buyer_id: current_user.id)
  end


  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to root
    # @task = Task.find(params[:id])
    # @task.update(task_params)
    # redirect_to @task
  end

  # def set_user
  #   if CreditCard.where(user_id: current_user.id).present?
  #     @card = CreditCard.where(user_id: current_user.id).first
  #   end 
  # end

  def favorites
    
  end

end
