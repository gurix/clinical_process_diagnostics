require 'rails_helper'

describe Client do
  it { is_expected.to validate_uniqueness_of(:identifier) }
  it { is_expected.to validate_presence_of(:identifier) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:class_of_age) }
  it { is_expected.to validate_uniqueness_of(:token) }
  it { is_expected.to validate_presence_of(:token_generated_at) }
  it { is_expected.to have_many(:sessions).with_dependent(:destroy).as_inverse_of(:client) }
  it { is_expected.to belong_to(:therapist).as_inverse_of(:clients) }

  it 'generates a view token automatically' do
    subject = create :client, therapist: create(:therapist)
    expect(subject.token).not_to be_empty
    expect(subject.token_generated_at).to be < DateTime.now
  end
end
