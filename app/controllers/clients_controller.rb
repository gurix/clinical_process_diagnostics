class ClientsController < ApplicationController
  before_action :find_or_initialize_client, only: :create
  before_action :load_therapists # Loads the list with all available therapists
  before_action :load_client, only: [:edit, :update]

  def show
    @client = Client.find_by(token: params[:token])
    @therapist = Therapist.find_by(token: params[:therapist_token])
    @sessions = @client.sessions.where(therapist: @therapist).asc(:create_at)
  end

  def edit; end

  def new
    @client = Client.new
  end

  def update
    redirect_to(new_client_session_path) && return if @client.update_attributes(client_params)
    render :edit
  end

  def create
    redirect_to(new_client_session_path) && return if @client.persisted? # The client already exists we can proceed directly
    @client.assign_attributes(client_params)
    redirect_to(new_client_session_path) && return if @client.second_step && @client.save
    render :new
  end

  private

  def find_or_initialize_client
    @client = Client.find_or_initialize_by(identifier: client_params[:identifier])
  end

  def client_params
    params.require(:client).permit(:identifier, :name, :class_of_age, :therapist_id, :second_step)
  end

  # Set the path depending on kind of survey used for last survey
  def new_client_session_path
    "/clients/#{@client.id}/#{@client.last_session_type.name.tableize}/new"
  end

  def load_therapists
    @therapists = Therapist.asc(:name)
  end

  def load_client
    @client = Client.find(params[:id])
  end
end
