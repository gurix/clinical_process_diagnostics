class Client
  include Mongoid::Document
  include Mongoid::Timestamps
  include Tokenable

  field :identifier, type: String
  field :name, type: String

  validates :identifier, presence: true
  validates :identifier, uniqueness: true
  validates :name, presence: true, unless: 'identifier.blank?'

  has_many :sessions, dependent: :destroy, inverse_of: :client, class_name: 'Survey::Session'

  def last_therapist
    sessions.last.therapist if sessions.any?
  end
end
