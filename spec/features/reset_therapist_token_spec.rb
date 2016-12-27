require 'rails_helper'

feature 'reset therapist token' do
  scenario 'a therapist enters an incorrect email address' do
    visit new_reset_therapist_token_path

    fill_in 'reset_therapist_token_email', with: 'hans@muster.de'

    click_button 'Zugriffsinformationen zusenden'

    expect(page).to have_content 'Die E-Mail-Adresse hans@muster.de existiert nicht.'
  end

  scenario 'a therapist enters the correct email address' do
    Therapist.create(name: 'Sigmund Freud', email: 'sigmund@sigmund-freud.at')

    visit new_reset_therapist_token_path

    fill_in 'reset_therapist_token_email', with: 'sigmund@sigmund-freud.at'

    expect { click_button 'Zugriffsinformationen zusenden' }.to change { ActionMailer::Base.deliveries.count }.by(1)

    expect(page).to have_content 'Ihre Zugriffsinformationen werden Ihnen in Kürze per E-Mail zugestellt.'
  end
end
