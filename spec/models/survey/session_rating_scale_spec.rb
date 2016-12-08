require 'rails_helper'

describe Survey::SessionRatingScale do
  it { is_expected.to validate_presence_of(:version) }

  it { is_expected.to belong_to(:client).as_inverse_of(:session_rating_scale_sessions) }
  it { is_expected.to belong_to(:therapist).as_inverse_of(:session_rating_scale_sessions) }
end
