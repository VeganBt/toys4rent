class UserController < ApplicationController
  def update
    if current_user.update(user_params)
      redirect_to bookings_path
    else
      render :bookings
    end
  end

  private

  def user_params
    params.require(:user).permit(:photo)
  end
end
