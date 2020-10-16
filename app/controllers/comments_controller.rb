class CommentsController < ApplicationController
before_action :set_comment, only: :update
before_action :check_user, only: :update

  # コメント作成
  def create
    @comment = Comment.new(comment_params)
    @seller_of_product = User.find(@comment.product.seller_id)
    if @comment.save
      respond_to do |format|
        format.json
      end
    else
      flash[:alert] = "保存できていません"
      redirect_to product_path(@comment.product.id)
    end
  end

  # 削除
  def update
    @comment.update(delete_check:1)
    @seller_of_product = User.find(@comment.product.seller_id)
  end

  private
    def comment_params
      params.require(:comment).permit(:body,:product_id).merge(user_id: current_user.id)
    end

    def set_comment
      @comment = Comment.find(params[:id])
    end

    # 出品者以外が直接URLアクセスするのを防止
    def check_user
      unless @comment.product.seller == current_user
        flash[:alert] = "その操作はできません"
        redirect_to root_path
      end
    end
end
