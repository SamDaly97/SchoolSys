class ProblemsController < ApplicationController
  before_action :set_problem, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show, :index]
  require 'my_logger'
  # GET /problems
  # GET /problems.json
  def index
    @problems = Problem.all
    if params[:search]
      @search_term = params[:search]
      @problems = @problems.search_by(@search_term)
    end
  end

  # GET /problems/1
  # GET /problems/1.json
  def show
  end

  # GET /problems/new
  def new
    @problem = current_user.problems.build
  end

  # GET /problems/1/edit
  def edit
  end

  # POST /problems
  # POST /problems.json
  def create
    @problem = current_user.problems.build(problem_params)
    logger = MyLogger.instance
     logger.logInformation("A new question was asked: " + @problem.question)
    @problem.user = current_user
    respond_to do |format|
      if @problem.save
        format.html { redirect_to @problem, notice: 'Problem was successfully created.' }
        format.json { render :show, status: :created, location: @problem }
      else
        format.html { render :new }
        format.json { render json: @problem.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /problems/1
  # PATCH/PUT /problems/1.json
  def update
    @problem.subject = params[:problem][:subject]
    @problem.topic = params[:problem][:topic]
    @problem.question = params[:problem][:question]
    updated_information = {
      "subject" => @problem.subject,
      "topic" => @problem.topic,
      "question" => @problem.question
    }
    respond_to do |format|
      if @problem.update(problem_params)
        format.html { redirect_to @problem, notice: 'Problem was successfully updated.' }
        format.json { render :show, status: :ok, location: @problem }
      else
        format.html { render :edit }
        format.json { render json: @problem.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /problems/1
  # DELETE /problems/1.json
  def destroy
    @problem.destroy
    respond_to do |format|
      format.html { redirect_to problems_url, notice: 'Problem was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_problem
      @problem = Problem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def problem_params
      params.require(:problem).permit(:subject, :topic, :question)
    end
end
