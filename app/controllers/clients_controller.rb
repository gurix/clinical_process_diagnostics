class ClientsController < ApplicationController
  def new
    @client = Client.new
  end

  def create
    @client = Client.find_or_initialize_by(identifier: client_params[:identifier])
    @client.valid? if client_params[:identifier].blank? # Perform validation so that the error message appears
    @client.name = client_params[:name] # Assign client name afterwards
    redirect_to('https://www.microsoft.com') && return if client_params[:ask_for_name].present? && @client.save # Start new questionary if everything is fine
    render :new
  end

  private

  def client_params
    params.require(:client).permit(:identifier, :name, :ask_for_name)
  end
end
