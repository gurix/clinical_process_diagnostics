require 'rails_helper'

describe Therapist do
  it { is_expected.to validate_uniqueness_of(:email) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:token) }

  it 'generates a view token automatically' do
    subject = create :therapist
    expect(subject.token).not_to be_empty
  end

  it { is_expected.to have_many(:session_rating_scale_sessions).with_dependent(:destroy).as_inverse_of(:therapist) }
end
