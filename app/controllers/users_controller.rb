class UsersController < ApplicationController
  # params.require(:product).permit(:name, :description, :photo)
  def show
    @user = current_user
  end
end
