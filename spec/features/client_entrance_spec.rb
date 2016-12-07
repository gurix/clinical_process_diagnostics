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

    click_button 'Weiter'
    expect(current_url).to eq 'https://www.microsoft.com/'
  end
end
