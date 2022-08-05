class Reports::CommentsController < ApplicationController
  before_action :set_commentable

  def create
    # 特定のレポートもしくはブックのコメント一覧に対してnewしており、その初期値にcomment_paramsで:commentなどを渡している。特定のレポート／ユーザーに対してnewするため、commentable_typeとcommentable_idは自動的に入る。しかし、まだuser_idは入っていない。
    @comment = @commentable.comments.new(comment_params)

    #user_idを@commentの中に代入する
    # @comment = current_user.comments.new(comment_params)でも大丈夫そう？→あとで確認する
    @comment.user_id = current_user.id

    if @comment.save
      redirect_to request.referer, notice: "コメントを投稿しました"
    else
      redirect_to request.referer, notice: "コメントの投稿に失敗しました"
    end
  end

  def destroy
    @comment = Comment.find_by(params[:report_id])
    if @comment.user_id == current_user.id
      @comment.destroy
      redirect_to request.referer, notice: "コメントを削除しました"
    else
      redirect_to request.referer
    end
  end

  private

  def set_commentable
    # Routesを確認したときに、Pathの中の「:book_id」や「:report_id」と、POSTとして送られたデータがparamsとして送られる。その中にuser_idは入っていないため、このファイル内でnewする必要がある。
    @commentable = Book.find_by(params[:book_id]) if Book.find_by(params[:book_id])
    @commentable = Report.find_by(params[:report_id]) if Report.find_by(params[:report_id])
  end

  def comment_params
    params.require(:comment).permit(:comment, :book_id, :report_id)
  end

end
