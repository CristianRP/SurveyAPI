# modulos APi::v1:UsersController
# se usan para reciclar/reutilizar codigo y para organizar
# namespaces, no confudimos el nombre de la clase con otra
class Api::V1::UsersController < ApplicationController
  #cuando son nuevos los crea y cuando encuentra un ya existente genera un token
  # POST /users
  def create  #esperamos el uid provider
    #params = { auth: { provider: 'facebook', uid: '123adf' }}
    @user = User.from_omniauth(params[:auth])
    #@token = Token.create(user: @user)
    @token = @user.tokens.create()

    render "api/v1/users/show"
  end
end
