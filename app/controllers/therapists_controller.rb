class TherapistsController < ApplicationController
  def index
    @therapists = Therapist.asc(:name)
  end

  def show
    @therapist = Therapist.find_by(token: params[:token])
  end
end
