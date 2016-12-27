class Client
  include Mongoid::Document
  include Mongoid::Timestamps
  include Tokenable

  field :identifier, type: String
  field :name, type: String

  validates :identifier, presence: true
  validates :identifier, uniqueness: true
  validates :name, presence: true, unless: 'identifier.blank?'

  has_many :session_rating_scale_sessions, dependent: :destroy, class_name: 'Survey::SessionRatingScale', inverse_of: :client

  def sessions
    session_rating_scale_sessions.asc(:created_at)
  end

  def last_therapist
    sessions.last.therapist if sessions.any?
  end
end
