require 'rails_helper'

feature 'edit client' do
  scenario 'a client changes his preferences' do
    sigmund = Therapist.create(name: 'Sigmund Freud', email: 'sigmund@sigmund-freud.at')
    Therapist.create(name: 'Dr. Paul Weston', email: 'paul.weston@intreatment.movie')

    client = create :client, therapist: sigmund, class_of_age: 'adult'

    visit edit_client_path(client)

    select 'Dr. Paul Weston', from: 'client_therapist_id'

    choose 'Kind / Jugendlich'

    click_button 'Weiter'

    expect(current_path).to eq new_client_survey_children_session_rating_scale_path(Client.last)

    expect(page).to have_content 'Dr. Paul Weston'
  end
end
