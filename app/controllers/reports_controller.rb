class ReportsController < ApplicationController
  before_action :set_report, only: %i[ show ]
  before_action :ensure_user, only: [:edit, :update, :destroy]

  def index
    @reports = Report.order(:id).page(params[:page])
  end

  def show
    @comments = @report.comments
    # 特定のレポートに紐付けられたコメント群に対して新しいインスタンスを作成するから下の記述になる
    @comment = @report.comments.new
  end

  def new
    @report = Report.new
  end

  def edit
  end

  def create
    @report = Report.new(report_params)
    @report.user_id = current_user.id

    respond_to do |format|
      if @report.save
        format.html { redirect_to report_url(@report), notice: "Report was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @report.update(report_params)
        format.html { redirect_to report_url(@report), notice: "Report was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @report.destroy

    respond_to do |format|
      format.html { redirect_to reports_url, notice: "Report was successfully destroyed." }
    end
  end

  private
    def set_report
      @report = Report.find(params[:id])
    end

    def report_params
      params.require(:report).permit(:title, :content, :user_id)
    end

    def ensure_user
      @reports = current_user.reports
      @report = @reports.find_by(id: params[:id])
      redirect_to new_report_path unless @report
    end

end
