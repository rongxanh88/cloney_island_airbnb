require "rails_helper"

RSpec.describe "JWT Access Token", :type => :request do
  it "creates a JWT when an HTTP request comes in" do
    token = SecureRandom.uuid.gsub(/\-/,'')
    user = create(:user, api_token: token)
    authorization = {Authorization: token}

    get '/api/v1/access_token.json', params: nil, headers: authorization
    result = JSON.parse(response.body, symbolize_names: true)
    decoded_token = JWT.decode(
      result[:access_token], ENV['hmac_secret'], true, { algorithm: 'HS256' }
    )

    expect(response).to have_http_status(200)
    expect(decoded_token.first["user_id"]).to eq(user.id)
  end

  it "responds with a status of 401 if no header or improper token" do
    get '/api/v1/access_token.json'
    result = JSON.parse(response.body, symbolize_names: true)

    expect(result[:status]).to eq(401)
    expect(result[:message]).to eq("Unauthorized User")
  end
end
