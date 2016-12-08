class ClientsController < ApplicationController
  before_action :find_or_initialize_client, only: :create

  def new
    @client = Client.new
  end

  def create
    redirect_to(new_client_survey_session_rating_scale_path(@client)) && return if @client.persisted?
    @client.name = client_params[:name] # Assign client name afterwards
    redirect_to(new_client_survey_session_rating_scale_path(@client)) && return if client_params[:ask_for_name] && @client.save
    render :new
  end

  private

  def find_or_initialize_client
    @client = Client.find_or_initialize_by(identifier: client_params[:identifier])
  end

  def client_params
    params.require(:client).permit(:identifier, :name, :ask_for_name)
  end
end
