class BookingsController < ApplicationController
  before_action :set_booking, only: [:edit, :update, :show, :destroy]

  def index
    @bookings = Booking.all
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.toy = Toy.find(params[:toy_id])
    if @booking.save
      redirect_to root_path # TODO: change this to the correct path
    else
      render :new
    end

    def show
    end

    def destroy
      @booking.destroy
      redirect_to root_path # TODO: change this to the correct path
    end

    def edit
    end

    def update
      if @booking.update(booking_params)
        redirect_to root_path # TODO: change this to the correct path
      else
        render :new
      end
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end

  def set_booking
    @booking = Booking.find(params[:id])
    @toy = @booking.toy
  end
end
