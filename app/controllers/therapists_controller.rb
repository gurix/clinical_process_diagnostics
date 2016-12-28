class TherapistsController < ApplicationController
  http_basic_authenticate_with name: '', password: ENV['ADMIN_PASS'], only: :index

  def index
    @therapists = Therapist.asc(:name)
  end

  def show
    @therapist = Therapist.find_by(token: params[:token])
  end
end
