require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :request do
  #agrupar pruebas tambien se puede usar context
  describe "POST /users" do
    # se ejuecuta antes de todas las pruebas
    before :each do
      auth = { auth: { provider: "facebook", uid: "165431dsf", info: { email: "c@gmail.com" } } }
      post "/api/v1/users/", { params: auth }
    end

    it { have_http_status(200) }

    it { change(User, :count).by(1) }

    it "responds with the user found or created" do
      json = JSON.parse(response.body)
      expect(json["email"]).to eq("c@gmail.com")
    end
  end
end
