class SessionsController < ApplicationController

  def new
    redirect_to root_path if current_user
    @user = User.new
  end

  def create
    if @user = User.find_by(email: params[:session][:email])
      if @user && @user.authenticate(params[:session][:password])
        @user && @user.authenticate(params[:session][:password])
        session[:user_id] = @user.id
        flash[:success] = "Logged in as #{@user.first_name}"
        if @user.host?
          redirect_to host_dashboard_index_path
        else
          redirect_to user_dashboard_index_path(@user)
        end
      end
    elsif user = User.from_omniauth(request.env['omniauth.auth'])
      session[:user_id] = user.id
      redirect_to user_dashboard_index_path(user.id)
    else
      flash[:login_error] = "The email or password you entered is invalid"
      render :new
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end

end
