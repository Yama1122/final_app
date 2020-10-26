class Products::SearchesController < ApplicationController
  def index
    # キーワードが空の場合
    if params[:keyword] == "" 
      redirect_to root_path, notice: 'キーワードを入力してください'
    else 
      # 変数@productsに検索結果を渡す searchメソッドの呼び出し
      @products = Product.search(params[:keyword])
    end
  end
end
