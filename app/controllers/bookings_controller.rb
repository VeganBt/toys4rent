class BookingsController < ApplicationController
  before_action :set_booking, only: [:edit, :update, :show, :destroy]

  def index
    @user = current_user
  end

  def new
    @booking = Booking.new
    @toy = Toy.find(params[:toy_id])
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @toy = Toy.find(params[:toy_id])
    @booking.toy = @toy
    if available?
      if @booking.save
        redirect_to bookings_path
      else
        render :new
      end
    else
      flash.now.alert = "Sorry! Toy is not available for these dates. Please choose another date range."
      render :new
    end

  end

  def show
  end

  # def destroy
  #   @booking.destroy
  #   redirect_to root_path # TODO: change this to the correct path
  # end

  def edit
  end

  def update_status
    @booking = Booking.find(params[:id])
    # new_status = params[:status]
    # @booking.update(status: new_status)
    @booking.update(booking_params)
    redirect_to bookings_path
  end

  def update
    @booking.status = "pending"
    if @booking.update(booking_params)
      redirect_to bookings_path(anchor: "request-box")
    else
      render :edit
    end
  end

  def destroy
    @booking.destroy
    redirect_to bookings_path
  end

  def available?
    Booking.where("start_date <= ? AND end_date >= ? AND toy_id = #{@toy.id}", @booking.end_date, @booking.start_date).none?
  end

  private

  def booking_params
    params.require(:booking).permit(:message, :start_date, :end_date, :status)
  end

  def set_booking
    @booking = Booking.find(params[:id])
    @toy = @booking.toy
  end
end

{ booking: {

}}
