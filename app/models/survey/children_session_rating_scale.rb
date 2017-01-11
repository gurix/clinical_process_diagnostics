module Survey
  class ChildrenSessionRatingScale < Session
    field :version, type: Integer, default: 2

    validates :version, presence: true

    # The real survey fields
    field :relationship,       type: Integer, default: 0
    field :goals_and_topics,   type: Integer, default: 0
    field :approach_or_method, type: Integer, default: 0
    field :overall,            type: Integer, default: 0
    field :coping,             type: Integer, default: 0 # Extension of 3th version from Prof. Dr. Marcel Schaer Gmelch

    validates :relationship,       presence: true
    validates :goals_and_topics,   presence: true
    validates :approach_or_method, presence: true
    validates :overall,            presence: true
    validates :coping,             presence: true
  end
end
