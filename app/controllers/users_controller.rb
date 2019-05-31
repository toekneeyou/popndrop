class UsersController < ApplicationController
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to poopspace_user_path(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :photo)
  end
end
