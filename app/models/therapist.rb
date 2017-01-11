class Therapist
  include Mongoid::Document
  include Mongoid::Timestamps
  include Tokenable

  field :email,   type: String
  field :name,    type: String

  validates :email, presence: true
  validates :email, uniqueness: true
  validates :name, presence: true

  has_many :sessions, dependent: :destroy, inverse_of: :therapist, class_name: 'Survey::Session'

  def clients
    sessions.map(&:client).uniq.sort_by(&:name)
  end
end
