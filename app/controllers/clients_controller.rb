class ClientsController < ApplicationController
  before_action :find_or_initialize_client, only: :create

  def show
    @client = Client.find_by(token: params[:token])
    @therapist = Therapist.find_by(token: params[:therapist_token])
    @session_rating_scale_sessions = @client.session_rating_scale_sessions.where(therapist: @therapist).asc(:create_at)
  end

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
