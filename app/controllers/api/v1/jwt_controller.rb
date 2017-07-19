class Api::V1::JwtController < ActionController::API
  def create
    if request.headers[:authorization]
      user = User.find_by(api_token: request.headers[:Authorization])
      payload = {user_id: user.id}
      jwt = JWT.encode payload, ENV['hmac_secret'], 'HS256'
      render json: {
        status: 200,
        access_token: jwt
      }.to_json
    else
      render json: {
        status: 400,
        message: "Authorization header not set."
      }.to_json
    end
  end
end
