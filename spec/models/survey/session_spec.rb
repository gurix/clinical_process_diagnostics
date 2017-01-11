require 'rails_helper'

describe Survey::Session do
  it { is_expected.to belong_to(:client).as_inverse_of(:sessions) }
  it { is_expected.to belong_to(:therapist).as_inverse_of(:sessions) }

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
