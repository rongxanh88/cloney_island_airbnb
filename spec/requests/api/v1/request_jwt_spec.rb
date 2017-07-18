require "rails_helper"

RSpec.describe "JWT Access Token", :type => :request do
  it "creates a JWT when an HTTP request comes in" do
    token = SecureRandom.uuid.gsub(/\-/,'')
    authorization = {authorization: token}
    get '/api/v1/access.json', params: nil, headers: authorization
    binding.pry

    expect(response).to have_http_status(200)
  end
end