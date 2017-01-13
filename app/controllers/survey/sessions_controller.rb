module Survey
  class SessionsController < ApplicationController
    before_action :set_type

    before_action :load_client
    before_action :load_therapists # Loads the list with all available therapists

    def new
      @session = type_class.new(therapist: @client.last_therapist)
    end

    def create
      @session = type_class.new session_params
      @session.client = @client

      @session.therapist = @client.therapist # Ensure we always state which therapist guided the session

      if @session.save
        flash[:success] = t('.session_suceessfully_created')
        redirect_to root_path
        return
      end
      render :new
    end

    private

    def set_type
      @type = type
    end

    def type
      Survey.const_get(params[:type]).included_modules.include?(Mongoid::Document) ? params[:type] : 'Survey::Session'
    end

    def type_class
      type.constantize
    end

    def load_client
      @client = Client.find(params[:client_id])
    end

    def load_therapists
      @therapists = Therapist.asc(:name)
    end

    def session_params
      params.require("survey_#{type.demodulize.underscore}").permit(:therapist_id, :relationship, :goals_and_topics, :approach_or_method, :overall, :coping)
    end
  end
end
