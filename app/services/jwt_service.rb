class JWTService
  attr_reader :status, :message, :request, :jwt, :api_token

  def initialize(request)
    @request = request
    set_api_token
    encode_jwt
  end
  
  def self.create(request)
    JWTService.new(request)
  end

  private
    def encode_jwt
      user = User.find_by(api_token: @api_token)
      if user.nil?
        unauthorized_user
      else
        payload = {user_id: user.id}
        @jwt = JWT.encode(payload, ENV['hmac_secret'], 'HS256')
      end
    end

    def set_api_token
      if request.headers[:Authorization]
        @api_token = request.headers[:Authorization]
      end
    end

    def unauthorized_user
      @status = 401
      @message = "Unauthorized User"
    end
end