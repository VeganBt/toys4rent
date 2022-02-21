class ToysController < ApplicationController
  before_action :set_toy, only: [:edit, :update]

  def index
    @toys = Toy.all
  end

  def new
    @toy = Toy.new
  end

  def create
    @toy = Toy.new(toy_params)
    if @toy.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def toy_params
    params.require(:toy).permit(:name, :description, :category, :user_id)
  end

  def set_toy
    @toy = Toy.find(params[:id])
  end
end
