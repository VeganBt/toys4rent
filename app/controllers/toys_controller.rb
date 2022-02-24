class ToysController < ApplicationController
  before_action :set_toy, only: [:edit, :update]
  # skip_before_action :authenticate_user!, only: :index

  def index
    if params[:query].present?
      sql_query = " \
      toys.name @@ :query \
      OR toys.category @@ :query \
      OR toys.description @@ :query \
      OR users.first_name @@ :query \
      OR users.last_name @@ :query \
      OR users.address @@ :query \
      OR users.city @@ :query \
      OR users.country @@ :query \
      "
      @toys = Toy.joins(:user).where(sql_query, query: "%#{params[:query]}%")
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

  private

  def toy_params
    params.require(:toy).permit(:name, :description, :category, :photo)
  end

  def set_toy
    @toy = Toy.find(params[:id])
  end
end
