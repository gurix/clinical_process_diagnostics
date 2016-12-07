class Therapist
  include Mongoid::Document
  include Mongoid::Timestamps

  field :email,   type: String
  field :name,    type: String

  validates :email, presence: true
  validates :email, uniqueness: true
  validates :name, presence: true
end
