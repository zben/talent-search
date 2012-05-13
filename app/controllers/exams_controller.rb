class ExamsController < ApplicationController
  before_filter :authenticate!
  def new
    @exam = Exam.new
  end

  def create
    @exam = Exam.new(params[:exam])
    if @exam.save
      redirect_to root_url, :notice => "Successfully created exam."
    else
      render :action => 'new'
    end
  end
end
