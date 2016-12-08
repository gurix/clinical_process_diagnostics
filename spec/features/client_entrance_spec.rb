require 'rails_helper'

feature 'client entrance' do
  scenario 'a new client start a survey' do
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
  end
end
