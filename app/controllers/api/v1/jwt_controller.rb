class Api::V1::JwtController < ActionController::API
  def create
    service = JWTService.create(request)
    if service.jwt
      render json: {status: 200, access_token: service.jwt}
    else
      render json: {status: service.status, message: service.message}
    end
  end
end
