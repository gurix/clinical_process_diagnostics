module Survey
  class SessionRatingScale
    include Mongoid::Document
    include Mongoid::Timestamps

    field :version, type: Integer, default: 4

    validates :version, presence: true

    belongs_to :client, inverse_of: :session_rating_scale_sessions
    belongs_to :therapist, inverse_of: :session_rating_scale_sessions

    # The real survey fields
    field :relationship, type: Integer
    field :goals_and_topics, type: Integer
    field :approach_or_method, type: Integer
    field :overall, type: Integer
    field :coping, type: Integer # Extension of 3th version from Prof. Dr. Marcel Schaer Gmelch

    validates :relationship,       presence: true
    validates :goals_and_topics,   presence: true
    validates :approach_or_method, presence: true
    validates :overall,            presence: true
    validates :coping,             presence: true
  end
end
