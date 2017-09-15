class UsersController < ApplicationController
  include ConfirmationSender

  def new
    @user = User.new
    flash[:error] = "All fields must be filled in."
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.roles << Role.find_by(name: "traveler")
      session[:user_id] = @user.id
      ConfirmationSender.send_confirmation_to(@user)
      redirect_to new_confirmation_path
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to user_dashboard_index_path(@user)
    else
      render 'edit'
    end
  end


  private

  def user_params
    params.require(:user)
          .permit(
            :email, :first_name, :last_name, :password, :phone_number,
            :birthday, :profile_picture, :verification_code
            )
  end

end
