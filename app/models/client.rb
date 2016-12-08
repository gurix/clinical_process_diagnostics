class Client
  include Mongoid::Document
  include Mongoid::Timestamps

  field :identifier, type: String
  field :name, type: String

  validates :identifier, presence: true
  validates :identifier, uniqueness: true
  validates :name, presence: true, unless: 'identifier.blank?'

  has_many :session_rating_scale_sessions, dependent: :destroy, class_name: 'Survey::SessionRatingScale', inverse_of: :client
end
