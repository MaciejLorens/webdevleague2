class DiagramsController < ApplicationController
  def index
    @diagrams = Diagram.all
  end

  def show
    @diagram = Diagram.find(params[:id])
  end

  def new
    @diagram = Diagram.new
  end

  def create
    @diagram = Diagram.create(diagram_params)

    if @diagram.save
      redirect_to action: :index, notice: 'success'
    else
      redirect_to action: :index, notice: 'fail'
    end
  end

  private

  def diagram_params
    params.require(:diagram).permit(:image)
  end
end
