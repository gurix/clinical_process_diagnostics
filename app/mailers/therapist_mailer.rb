class TherapistMailer < ActionMailer::Base
  include Roadie::Rails::Automatic

  default from: 'from@example.com'
  layout 'mailer'

  def reset_token(therapist_id)
    @therapist = Therapist.find(therapist_id)
    @therapist.reset_token
    @therapist.save

    mail to: @therapist.email, subject: I18n.translate('emails.reset_token.subject', name: @therapist.name)
  end
end
