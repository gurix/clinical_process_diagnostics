require 'rails_helper'

feature 'session rating scale input' do
  scenario 'a new client fills a survey' do
    Therapist.create(name: 'Sigmund Freud', email: 'sigmund@sigmund-freud.at')
    Therapist.create(name: 'Dr. Paul Weston', email: 'paul.weston@intreatment.movie')

    visit new_client_path

    fill_in 'Bitte geben Sie ihre Klienten-Nummer an.', with: 'test'

    click_button 'Weiter'

    expect(page).to_not have_content 'Bitte geben Sie ihre Klienten-Nummer an'

    expect(page).to have_content 'Bitte geben Sie ihren Namen an'
    expect(page).to_not have_content 'muss ausgefüllt werden'

    click_button 'Weiter'

    expect(page).to have_content 'muss ausgefüllt werden'

    fill_in 'Bitte geben Sie ihren Namen an.', with: 'Hanf Ueli'

    expect { click_button 'Weiter' }.to change { Client.count }.by(1)

    expect(current_path).to eq new_client_survey_session_rating_scale_path(Client.last)

    select 'Dr. Paul Weston', from: 'survey_session_rating_scale_therapist_id'

    find("input[id$='survey_session_rating_scale_relationship']").set 10
    find("input[id$='survey_session_rating_scale_goals_and_topics']").set 20
    find("input[id$='survey_session_rating_scale_approach_or_method']").set 10
    find("input[id$='survey_session_rating_scale_overall']").set 20
    find("input[id$='survey_session_rating_scale_coping']").set 10

    click_button 'Speichern'

    expect(page).to have_content 'Ihre Bewertung wurde erfolgreich gepeichert. Besten Dank.'

    expect(current_path).to eq root_path
  end

  scenario 'starting a new survey it assigns automatically the last used therapist' do
    create :therapist, name: 'David Hasselhoff'
    first_therapist = create :therapist, name: 'Donald Trump'
    second_therapist = create :therapist, name: 'Hillary Clinton'

    client = create :client

    visit new_client_survey_session_rating_scale_path(client)
    expect(page).not_to have_select('survey_session_rating_scale_therapist_id', selected: 'David Hasselhoff')
    expect(page).not_to have_select('survey_session_rating_scale_therapist_id', selected: 'Donald Trump')
    expect(page).not_to have_select('survey_session_rating_scale_therapist_id', selected: 'Hillary Clinton')

    create :session_rating_scale, client: client, therapist: first_therapist

    visit new_client_survey_session_rating_scale_path(client)

    expect(page).to have_select('survey_session_rating_scale_therapist_id', selected: 'Donald Trump')

    create :session_rating_scale, client: client, therapist: second_therapist

    visit new_client_survey_session_rating_scale_path(client)

    expect(page).to have_select('survey_session_rating_scale_therapist_id', selected: 'Hillary Clinton')
  end
end
