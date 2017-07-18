class Api::V1::JwtController < ActionController::API

  def create
    #get HTTP request, need token in header
    binding.pry
    if request.headers[:authorization]
      #do this
    else
      render json: {
        status: 400,
        message: "Authorization header not set."
      }.to_json
    end
  end

end