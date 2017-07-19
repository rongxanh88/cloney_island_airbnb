class Permission

  def initialize(user = nil, controller, action)
    @user = user || User.new
    @controller = controller
    @action = action
  end

  def authorized?
    if user.admin?
      admin_permissions
    elsif user.host?
      host_permissions
    elsif user.traveler?
      traveler_permissions
    else
      return false
    end
  end

  private
    attr_reader :user, :controller, :action

    def traveler_permissions
      return true if controller == "sessions"
      return true if controller == "confirmations" && action.in?(%w(new create))
      return true if controller == "dashboard" && action.in?(%w(index))
      return true if controller == "homepage" && action.in?(%w(index))
      return true if controller == "listings" && action.in?(%w(index show))
      return true if controller == "trips" && action.in?(%w(index new create))
      return true if controller == "users" && action.in?(%w(new create edit update))
    end

    def host_permissions
      return true if controller == "sessions"
      return true if controller == "confirmations" && action.in?(%w(new create))
      return true if controller == "dashboard" && action.in?(%w(index))
      return true if controller == "homepage" && action.in?(%w(index))
      return true if controller == "listings" && action.in?(%w(index show new create update))
      return true if controller == "trips" && action.in?(%w(index new create))
      return true if controller == "users" && action.in?(%w(new create edit update))
    end

    def admin_permissions
      return true if controller == "sessions"
      return true if controller == "confirmations" && action.in?(%w(new create))
      return true if controller == "dashboard" && action.in?(%w(index))
      return true if controller == "homepage" && action.in?(%w(index))
      return true if controller == "listings" && action.in?(%w(index show new create update))
      return true if controller == "trips" && action.in?(%w(index new create))
      return true if controller == "users" && action.in?(%w(new create edit update))
    end

end
