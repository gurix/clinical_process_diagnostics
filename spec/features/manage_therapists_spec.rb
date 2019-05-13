require 'rails_helper'

feature 'manage therapists' do
  scenario 'displaying a list with all therapists' do
    create :therapist, name: 'Hansli Muster'
    create :therapist, name: 'Heiri Müller'

    visit therapists_path

    expect(page).to have_content 'Hansli Muster'
    expect(page).to have_content 'Heiri Müller'
  end

  scenario 'creating a therapist' do
    visit new_therapist_path

    fill_in 'Name', with: 'Hans Muster'
    fill_in 'E-Mail', with: 'stupidwhiteman@trump.com'

    expect { click_button 'Speichern' }.to change { Therapist.count }.by(1)
  end

  scenario 'editing a therapist' do
    therapist = create :therapist, name: 'Hansli Muster'

    visit edit_therapist_path(therapist)
    expect(therapist.reload.disabled).not_to eq true

    fill_in 'Name', with: 'Hans Muster'
    check 'Therapeut nicht mehr in der Liste anzeigen.'

    click_button 'Speichern'

    expect(therapist.reload.name).to eq 'Hans Muster'
    expect(therapist.reload.disabled).to eq true
  end

  scenario 'deleting a therapist' do
    therapist = create :therapist, name: 'Hansli Muster'

    visit edit_therapist_path(therapist)

    expect { click_link 'Therapeut löschen' }.to change { Therapist.count }.by(-1)
  end
end
