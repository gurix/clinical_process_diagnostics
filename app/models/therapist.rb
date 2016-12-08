class Therapist
  include Mongoid::Document
  include Mongoid::Timestamps

  field :email,   type: String
  field :name,    type: String

  validates :email, presence: true
  validates :email, uniqueness: true
  validates :name, presence: true

  has_many :session_rating_scale_sessions, dependent: :destroy, class_name: 'Survey::SessionRatingScale', inverse_of: :therapist
end
