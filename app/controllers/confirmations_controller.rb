class ConfirmationsController < ApplicationController
  def new
    if session[:user_id]
      @user = User.find(session[:user_id])
    else
      @user = current_user
      session[:user_id] = @user.id
    end
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
