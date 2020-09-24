class CreditCardsController < ApplicationController
  require 'payjp'
  before_action :set_user

  def new

  end

  def create
    # PAY.JPの秘密鍵をセット（環境変数）
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]

    # jsにてpayjpTokenをセットできているか
    if params['payjp-token'].blank?
      render :new
    else
      # pay.jpに登録されるユーザーの作成
      customer = Payjp::Customer.create(
        email:current_user.email,
        card:params['payjp-token'],
        metadata: {user_id: current_user.id}
      )
      @card = CreditCard.new(user_id: current_user.id,customer_id: customer.id,card_id:customer.default_card)
      if @card.save
        redirect_to user_path(current_user.id)
      else
        render :new
      end
    end


  end
  
  private
  def set_user
    if CreditCard.where(user_id: current_user.id).present?
      @card = CreditCard.where(user_id: current_user.id).first
    end 
  end


end
