require 'rails_helper'

describe Survey::ChildrenSessionRatingScale do
  it { is_expected.to validate_presence_of(:relationship) }
  it { is_expected.to validate_presence_of(:goals_and_topics) }
  it { is_expected.to validate_presence_of(:approach_or_method) }
  it { is_expected.to validate_presence_of(:overall) }
  it { is_expected.to validate_presence_of(:coping) }
end
