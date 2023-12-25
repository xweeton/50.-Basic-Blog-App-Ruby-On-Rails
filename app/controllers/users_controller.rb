class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  # display user profile
  def show
  end

  # use for the view of edit
  def edit
    @user = User.find(params[:id])
  end

  # use for the runner of edit user data
  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'Your profile was successfully updated.'
    else
      render :edit
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name)
    end
end
