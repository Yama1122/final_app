class PurchasesController < ApplicationController
  require 'payjp'
  
  def confirmation
    # 商品情報の取得
    @product = Product.find(params[:product_id])
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
      redirect_to new_user_session_path, alert: "ログインしてください"
    end
  end
end
