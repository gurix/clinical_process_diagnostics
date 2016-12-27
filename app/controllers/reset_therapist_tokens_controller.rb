class ResetTherapistTokensController < ApplicationController
  def create
    begin
      therapist = Therapist.find_by(email: reset_therapist_token_params[:email])
      TherapistMailer.reset_token(therapist.id).deliver
      flash.now[:success] = t('.email_sent')
    rescue Mongoid::Errors::DocumentNotFound
      flash.now[:error] = t('.email_not_found', email: reset_therapist_token_params[:email])
    end
    render :new
  end

  def reset_therapist_token_params
    params.require(:reset_therapist_token).permit(:email)
  end
end
