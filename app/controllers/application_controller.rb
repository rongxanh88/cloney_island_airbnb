require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  before_action :assign_env_variables
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :authorize!

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_user
    unless current_user
      flash[:error] = 'You must be logged in to access this page.'
      redirect_to login_path
    end
  end

  def assign_env_variables
    gon.mapbox_api_key = ENV["MAPBOX_API_KEY"]
    gon.airbnb_key = ENV['airbnb_key']
  end

  private

    def authorize!
      permission = Permission.new(current_user, params[:controller], params[:action])
      raise ActionController::RoutingError.new('Not Found') unless permission.authorized?
    end

end
