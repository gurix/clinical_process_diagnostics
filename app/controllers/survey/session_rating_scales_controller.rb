module Survey
  class SessionRatingScalesController < ApplicationController
    before_action :load_client
    before_action :load_therapists # Loads the list with all available therapists

    def new
      @session_rating_scale = SessionRatingScale.new(therapist: @client.last_therapist)
    end

    def create
      @session_rating_scale = SessionRatingScale.new session_rating_scale_params
      @session_rating_scale.client = @client

      if @session_rating_scale.save
        flash[:success] = t('.session_suceessfully_created')
        redirect_to root_path
        return
      end
      render :new
    end

    private

    def load_client
      @client = Client.find(params[:client_id])
    end

    def load_therapists
      @therapists = Therapist.asc(:name)
    end

    def session_rating_scale_params
      params.require(:survey_session_rating_scale).permit(:therapist_id, :relationship, :goals_and_topics, :approach_or_method, :overall, :coping)
    end
  end
end
