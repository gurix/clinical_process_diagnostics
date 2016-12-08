module Survey
  class Srs
    include Mongoid::Document
    include Mongoid::Timestamps

    field :version, type: Integer, default: 4

    validates :version, presence: true

    belongs_to :client, inverse_of: :srs_sessions
    belongs_to :therapist, inverse_of: :srs_sessions
  end
end
