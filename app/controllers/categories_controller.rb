class CategoriesController < ApplicationController
  def index
  end

  def show
    @category = Category.find(params[:id])
    @products = @category.set_products
  end

  def search
    respond_to do |format|
      format.html
      format.json do
        if params[:parent_id]
          @childrens = Category.find(params[:parent_id]).children
        elsif params[:children_id]
          @grandChilds = Category.find(params[:children_id]).children
        end
      end
    end
  end

  private
  


  
end
