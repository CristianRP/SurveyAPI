require "rails_helper"

RSpec.describe Api::V1::MyPollsController, type: :request do

  describe "GET /polls" do

    before :each do
      FactoryGirl.create_list(:my_poll, 10)
      # FactoryGirl tiene la capicidad de crear listas
      get "/api/v1/polls"
    end

    it { have_http_status(200) }
    it "mande la lista de encuestas" do
      json = JSON.parse(response.body)
      expect(json.length).to eq(MyPoll.count)
    end
  end

  describe "GET /polls/:id" do

    before :each do
      @poll = FactoryGirl.create(:my_poll)
      get "/api/v1/polls/#{@poll.id}"
    end

    it { have_http_status(200) }

    #cuando se agrega una x a una prueba la deja pendiente
    it "manda la encuesta solicitada" do
      json = JSON.parse(response.body)
      expect(json["id"]).to eq(@poll.id)
    end

    it "manda los atributos de la encuesta" do
      json = JSON.parse(response.body)
      expect(json.keys).to contain_exactly("id", "title", "description", "expires_at", "user_id")
    end

  end

  describe "POST /polls" do
    #otra forma de agrupacion, agrupadas por contexto
    context "con token valido" do
      before :each do
        @token = FactoryGirl.create(:token, expires_at: DateTime.now + 10.minutes)
        puts "\n\n -- #{ @token } -- \n\n"
        @params = { token: @token.token, poll: {  title: "Hola mundo", description: "adsljf qowerut etw fg test", expires_at: DateTime.now } }
        post "/api/v1/polls", { params: @params}

        #puts "\n\n -- #{ @params } -- \n\n"
      end
      it { have_http_status(200) }
      it "crea una nueva encuesta" do
        #puts "\n\n -- #{ @params } -- \n\n"
        expect{
          post "/api/v1/polls", { params: @params }
        }.to change(MyPoll, :count).by(1)
      end
      it "responde con la encuesta creada" do
        json = JSON.parse(response.body)
        #puts "\n\n -- #{ json } -- \n\n"
        expect(json["title"]).to eq("Hola mundo")
      end
    end
    context "con token invalido" do
      before :each do
        post "/api/v1/polls"
      end

      it { have_http_status(401) }

      it "el token es invalido" do
        json = JSON.parse(response.body)
        puts "#{json}"
      end
    end

    context "unvalid params" do
      before :each do
        @token = FactoryGirl.create(:token, expires_at: DateTime.now + 10.minutes)
        @params = { token: @token.token, poll: {  title: "Hola mundo", expires_at: DateTime.now } }
        post "/api/v1/polls", { params: @params }
      end

      it { have_http_status(422) }

      it "responde con los errores al guardar la encuesta" do
        #puts "\n\n -- #{response.body} -- \n\n"
        json = JSON.parse(response.body)
        expect(json["errors"]).to_not be_empty
      end
    end
  end
end
