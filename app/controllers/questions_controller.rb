class QuestionsController < ApplicationController
  def index
    @questions = Question.all
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.create(question_params)

    if @question.save
      redirect_to action: :index, notice: 'success'
    else
      redirect_to action: :index, notice: 'fail'
    end
  end

  private

  def question_params
    params.require(:question).permit(:content)
  end
end
