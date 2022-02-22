class ToysController < ApplicationController
  before_action :set_toy, only: [:edit, :update]

  def index
    @toys = Toy.all
  end

  def new
    @toy = Toy.new

    @categories = %w[Action\ figures
                     Arts\ and\ Crafts
                     Books
                     Building\ &\ Construction
                     Collectable
                     Costumes
                     Dolls
                     Educational
                     Games\ &\ Puzzles
                     Infant\ Toys
                     Miscellaneous
                     Music
                     Plush
                     Ride\ Ons
                     Sports
                     Vehicles]
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

  private

  def toy_params
    params.require(:toy).permit(:name, :description, :category, :photo)
  end

  def set_toy
    @toy = Toy.find(params[:id])
  end
end
