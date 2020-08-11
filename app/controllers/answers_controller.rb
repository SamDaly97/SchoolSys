class AnswersController < ApplicationController
  def index
    @problem = Problem.find(params[:problem_id])
    @answers = @problem.answers
  end

  def show
    @problem = Problem.find(params[:problem_id])
    @answer = @problem.answers.find(params[:id])
  end

  def new
    @problem = Problem.find(params[:problem_id])
    @answer = @problem.answers.build
  end


  def create
      @problem = Problem.find(params[:problem_id])
      @answer = @problem.answers.build(params.require(:answer).permit(:reply))
      if @answer.save
        redirect_to problem_answer_url(@problem, @answer)
      else
        render :action => "new"
      end
  end


  def edit
    @problem = Problem.find(params[:problem_id])
    @answer = @problem.answers.find(params[:id])
  end


  def update
    @problem = Problem.find(params[:problem_id])
    @answer = Answer.find(params[:id])
    if @answer.update_attributes(params.require(:answer).permit(:reply))
      redirect_to problem_answer_url(@problem, @answer)
    else
      render :action => "edit"
    end
  end


  def destroy
    @problem = Problem.find(params[:problem_id])
    @answer = Answer.find(params[:id])
    @answer.destroy
    respond_to do |format|
      format.html { redirect_to problem_answers_path(@problem) }
      format.xml { head :ok }
    end
  end
end
