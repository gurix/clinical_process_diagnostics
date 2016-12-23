require 'rails_helper'

describe Survey::SessionRatingScale do
  it { is_expected.to validate_presence_of(:version) }

  it { is_expected.to validate_presence_of(:relationship) }
  it { is_expected.to validate_presence_of(:goals_and_topics) }
  it { is_expected.to validate_presence_of(:approach_or_method) }
  it { is_expected.to validate_presence_of(:overall) }
  it { is_expected.to validate_presence_of(:coping) }

  it { is_expected.to belong_to(:client).as_inverse_of(:session_rating_scale_sessions) }
  it { is_expected.to belong_to(:therapist).as_inverse_of(:session_rating_scale_sessions) }

  it 'returns the last used therapist' do
    client = create :client

    first_therapist = create :therapist
    second_therapist = create :therapist

    expect(client.last_therapist).to be nil

    create :session_rating_scale, client: client, therapist: first_therapist

    expect(client.last_therapist).to eq first_therapist

    create :session_rating_scale, client: client, therapist: second_therapist

    expect(client.last_therapist).to eq second_therapist

    create :session_rating_scale, client: client, therapist: first_therapist

    expect(client.last_therapist).to eq first_therapist
  end
end
