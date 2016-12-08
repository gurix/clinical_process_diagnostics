require 'rails_helper'

describe Survey::Srs do
  it { is_expected.to validate_presence_of(:version) }

  it { is_expected.to belong_to(:client).as_inverse_of(:srs_sessions) }
  it { is_expected.to belong_to(:therapist).as_inverse_of(:srs_sessions) }
end
