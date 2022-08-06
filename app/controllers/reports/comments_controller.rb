class Reports::CommentsController < ApplicationController
  before_action :set_commentable, only: %i[create]

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to request.referer, notice: "コメントを投稿しました"
    else
      redirect_to request.referer, notice: "コメントの投稿に失敗しました"
    end
  end

  def destroy
    @comment = Comment.find(params[:report_id])
    if @comment.user_id == current_user.id
      @comment.destroy
      redirect_to request.referer, notice: "コメントを削除しました"
    else
      redirect_to request.referer
    end
  end

  private

  def set_commentable
    @commentable = Report.find(params[:report_id])
  end

  def comment_params
    params.require(:comment).permit(:comment, :book_id, :report_id)
  end

end
