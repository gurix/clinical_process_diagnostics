class Therapist
  include Mongoid::Document
  include Mongoid::Timestamps
  include Tokenable

  field :email,    type: String
  field :name,     type: String
  field :disabled, type: Boolean, default: false

  validates :email, presence: true
  validates :email, uniqueness: true
  validates :email, email: true
  validates :name,  presence: true

  has_many :sessions, dependent: :destroy, inverse_of: :therapist, class_name: 'Survey::Session'
  has_many :clients, inverse_of: :therapist

  scope :active, -> { where(:disabled.ne => true) }

  def all_clients
    sessions.map(&:client).uniq.sort_by(&:name)
  end
end
