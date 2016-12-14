class TherapistsController < ApplicationController
  def index
    @therapists = Therapist.asc(:name)
  end

  def show
    @therapist = Therapist.find(params[:id])
  end
end
