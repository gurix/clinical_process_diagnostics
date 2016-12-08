module Survey
  class SessionRatingScale
    include Mongoid::Document
    include Mongoid::Timestamps

    field :version, type: Integer, default: 4

    validates :version, presence: true

    belongs_to :client, inverse_of: :session_rating_scale_sessions
    belongs_to :therapist, inverse_of: :session_rating_scale_sessions
  end
end
