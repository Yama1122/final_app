class PurchasesController < ApplicationController
  require 'payjp'
  
  # 購入確認
  def confirmation
    # 商品情報の取得
    @product = Product.find(params[:product_id])
    @cards = CreditCard.where(user_id: current_user.id)
    # ログインの確認
    if user_signed_in?
      @user = current_user
      # クレジット登録をしているか
      if @user.credit_card.present?
        # PAY.JPの秘密鍵をセット（環境変数）
        # 秘密鍵等は.envにて保管
        Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
        @card = CreditCard.find_by(user_id: current_user.id)
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
      else
        # クレジット登録ページへ遷移
        redirect_to new_credit_card_psth, alert: "クレジットカードの登録をしてください"
      end
    else
      # ログインページへ遷移
      redirect_to new_user_session_path, alert: "ログインしてください"
    end
  end

# 購入処理
  def pay
    card = CreditCard.where(user_id: current_user.id).first
    @product = Product.find(params[:id])
    # PAY.JPの秘密鍵をセット（環境変数）
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    Payjp::Charge.create(
    :amount => @product.price, #支払金額を入力
    :customer => card.customer_id, #顧客ID
    :currency => 'jpy', #日本円
    )
    # 購入処理後、製品にbuyer_idを付与することで購入済みかを判断
    @product.update(buyer_id:current_user.id)
    # 購入完了ページへ遷移
    redirect_to done_product_purchase_path(params[:id])
  end

# 購入完了
  def done
    # 商品情報の取得
    @product = Product.find(params[:product_id])
    @cards = CreditCard.where(user_id: current_user.id)
    # ログインの確認
    if user_signed_in?
      @user = current_user
      # クレジット登録をしているか
      if @user.credit_card.present?
        # PAY.JPの秘密鍵をセット（環境変数）
        Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
        @card = CreditCard.find_by(user_id: current_user.id)
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
      else
      end
    else
      # ログインページへ遷移
      redirect_to new_user_session_path, alert: "ログインしてください"
    end
  end
end
