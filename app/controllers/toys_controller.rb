class ToysController < ApplicationController
  before_action :set_toy, only: [:edit, :update]
  # skip_before_action :authenticate_user!, only: :index

  def index
    if params[:query].present?
      @toys = Toy.global_search(params[:query])
    else
      @toys = Toy.all
    end

    # Map variables
    toys_with_geo = @toys.select { |toy| toy.user.geocoded? }
    @markers = toys_with_geo.map do |toy|
      {
        lat: toy.user.latitude ? toy.user.latitude : 0.5,
        lng: toy.user.longitude ? toy.user.longitude : 0.5
      }
    end
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

  def edit
    @toy = Toy.find(params[:id])
  end

  def update
    @toy = Toy.find(params[:id])
    @toy.update(toy_params)

    redirect_to toys_path
  end

  private

  def toy_params
    params.require(:toy).permit(:name, :description, :category, :photo)
  end

  def set_toy
    @toy = Toy.find(params[:id])
  end
end
