class CommentsController < ApplicationController
  before_action :set_report

  def create
    @comment = @report.comments.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      format.html { redirect_to request.referer, notice: "コメントを投稿しました" }
    else
      format.html { redirect_to request.referer, notice: "コメントの投稿に失敗しました" }
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.user_id == current_user.id
      @comment.destroy
      format.html { redirect_to request.referer, notice: "コメントを削除しました" }
    else
      redirect_to request.referer
    end
  end

  private

  def set_report
    @report = Report.find(params[:report_id])
  end

  def comment_params
    params.require(:comment).permit(:comment)
  end

end
