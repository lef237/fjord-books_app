class CommentsController < ApplicationController
  before_action :set_commentable

  # TODO: user_idをAddColumnする

  def create
    # @commentはここでnewしても大丈夫？
    p comment_params
    p @commentable
    # @comment = current_user.comments.new(comment_params)

    @comment = @commentable.comments.new(comment_params)

    p @comment
    # @comment.user_id = current_user.id
    if @comment.save
      redirect_to request.referer, notice: "コメントを投稿しました"
    else
      redirect_to request.referer, notice: "コメントの投稿に失敗しました"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.user_id == current_user.id
      @comment.destroy
      redirect_to request.referer, notice: "コメントを削除しました"
    else
      redirect_to request.referer
    end
  end

  private

  def set_commentable
    p params
    p "aaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    @commentable = Book.find_by(params[:book_id]) if Book.find_by(params[:book_id])
    @commentable = Report.find_by(params[:report_id]) if Report.find_by(params[:report_id])
  end

  def comment_params
    params.require(:comment).permit(:comment, :book_id, :report_id, :user_id)
  end

end
