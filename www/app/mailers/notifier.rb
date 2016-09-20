class Notifier < ApplicationMailer
  default from: 'roy.wei@sarbeer.com'
  layout 'mailer'

  def cover_letter_contact(cover_letter)
    @cover_letter = cover_letter
    mail(to: cover_letter.job.company.email,
         subject: "#{cover_letter.resume.firstname + " " + cover_letter.resume.lastname} send a cover letter to you for #{cover_letter.job.title}")
  end
end

