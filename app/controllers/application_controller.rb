class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  # codigo que queremos ejecutar en todos los controladores
  # de nuestra aplicacion estan aqui

  #before_action :authenticate

  def authenticate
    token_str = params[:token]
    token = Token.find_by(token: token_str)
    # se puede buscar en la tabla de token
    #find espera por defualt el parametro id
    #find_by espera cualquier parametro y lo buscar nos devuelven un elemento
    #where nos devuelve una relacion de todos los elementos que cumplan con los parametros de busqueda

    if token.nil? || !token.is_valid?
      render json: { error: "Tu token es invalido", status: :unauthorized }
    else
      @current_user = token.user
    end

  end

end
