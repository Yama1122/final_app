class UsersController < ApplicationController
  before_action :set_user
  def show
  end

  def logout
  end

  def registration_select
  end

  def complete
  end

  def set_user
    if CreditCard.where(user_id: current_user.id).present?
      @card = CreditCard.where(user_id: current_user.id).first
    end 
  end

end
