class Api::V1::MyPollsController < ApplicationController

  before_action :authenticate, only: [:create, :update, :destroy]
  #en un mismo controlador habran acciones que requiera el usuario autenticado
  #para ver todas las encuestas o una, para el crud autenticado se coloca Only: o except

  def index
    @polls = MyPoll.all
  end

  def show
    @poll = MyPoll.find(params[:id])
  end

  def create
    @poll = @current_user.my_polls.new(my_polls_params)
    #poll = MyPoll.new(my_polls_params)
    #poll.user = @current_user
    if @poll.save
      render "api/v1/my_polls/show"
    else
      render json: { errors: @poll.errors.full_messages }, status: :unprocessable_entity
      #:unprocessable_entity
      #con los parametros que se mandaron no se pudieron crear la encuesta no se cumple alguna de las validaciones
    end
  end

  def update

  end

  def destroy

  end

  private
    def my_polls_params # filtra los parametros
      #validamos que el usuario no mande parametros
      #maliciosos a nuestra peticion
      params.require(:poll).permit(:title, :description, :expires_at)
    end

end
