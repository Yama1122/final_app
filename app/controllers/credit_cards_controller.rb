class CreditCardsController < ApplicationController
  require 'payjp'
  before_action :set_user

  # クレジット新規登録

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
        # クレジット登録完了ページへ
        redirect_to complete_credit_cards_path
      else
        # 新規登録ページへ
        render :new
      end
    end
  end

  # クレジット一覧/削除ページ
  def show
    @cards = CreditCard.where(user_id: current_user.id)
    # クレジットカード登録がない場合は新規登録画面へ
    if @card.blank?
      redirect_to new_credit_card_path
    else
      # PAY.JPの秘密鍵をセット（環境変数）
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      # ログインユーザーのクレジットカード情報からpayjpの顧客情報を引き出す
      customer = Payjp::Customer.retrieve(@card.customer_id)
      # 顧客情報からカードの情報を取り出す
      @customer_card = customer.cards.retrieve(@card.card_id)
      #カードのアイコン表示のため分岐
      @card_brand = @customer_card.brand
      case @card_brand
      when "Visa"
        @card_src = "VISA.png"
      when "JCB"
        @card_src = "JCB.png"
      when "MasterCard"
        @card_src = "mastercard.png"
      when "American Express"
        @card_src = "AmericanExpress.png"
      when "Discover"
        @card_src = "discover.png"
      end
      #更新月
      @exp_month = @customer_card.exp_month.to_s
      #更新年の下２桁
      @exp_year = @customer_card.exp_year.to_s.slice(2,3)
    end
  end

  # クレジット削除機能
  def destroy
    # クレジットカード登録がない場合は新規登録画面へ
    if @card.blank?
      redirect_to new_credit_card_path
    else
    # PAY.JPの秘密鍵をセット（環境変数）
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    # ログインユーザーのクレジットカード情報からpayjpの顧客情報を引き出す
      customer = Payjp::Customer.retrieve(@card.customer_id)
      customer.delete
      @card.delete
      if @card.delete
        # クレジットカード削除完了ページへ
        redirect_to delete_credit_cards_path
      else
        # クレジットカード一覧ページへ
        redirect_to credit_card_path(current_user.id),alert: "削除できませんでした。"
      end
    end
  end
  
  private
  def set_user
    if CreditCard.where(user_id: current_user.id).present?
      @card = CreditCard.find_by(user_id: current_user.id)
    end 
  end


end
