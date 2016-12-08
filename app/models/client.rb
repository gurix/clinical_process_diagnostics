class Client
  include Mongoid::Document
  include Mongoid::Timestamps

  field :identifier, type: String
  field :name, type: String

  validates :identifier, presence: true
  validates :identifier, uniqueness: true
  validates :name, presence: true

  has_many :srs_sessions, dependent: :destroy, class_name: 'Survey::Srs', inverse_of: :client
end
