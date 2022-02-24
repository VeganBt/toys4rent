class ToysController < ApplicationController
  before_action :set_toy, only: [:edit, :update]
  # skip_before_action :authenticate_user!, only: :index

  def index
    @toys = Toy.all
  end

  def new
    @toy = Toy.new
  end

  def create
    @toy = Toy.new(toy_params)
    @toy.user = current_user
    if @toy.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @toy = Toy.find(params[:id])
  end

  private

  def toy_params
    params.require(:toy).permit(:name, :description, :category, :photo)
  end

  def set_toy
    @toy = Toy.find(params[:id])
  end
end
