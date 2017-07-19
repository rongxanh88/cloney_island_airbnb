class ConfirmationsController < ApplicationController
  def new
    @user = User.find(session[:user_id])
  end

  def create
    @user = User.find(session[:user_id])
    if @user.verification_code == params["confirmations"]["verification_code"]

      session[:authenticated] = true

      flash[:notice] = "Welcome #{@user.first_name}. Find Your Next Adventure!"

      redirect_to user_dashboard_index_path(@user)

    else

      flash.now[:error] = "Verification code is incorrect."

      render :new
    end
  end
end
