class Products::SearchesController < ApplicationController
  def index
    @products = Product.all
    @products = Product.search(params[:keyword])
  end
end
