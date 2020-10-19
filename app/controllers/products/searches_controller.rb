class Products::SearchesController < ApplicationController
  # 変数@productsに検索結果を渡す　searchメソッドの呼び出し
  def index
    @products = Product.search(params[:keyword])
  end
end
