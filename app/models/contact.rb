class Contact < MailForm::Base
  attribute :name,      :validate => true, message: "Please provide your name."
  attribute :email,     :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :file,      :attachment => true

  attribute :message
  attribute :nickname,  :captcha  => true

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
      :subject => "DHPA.com Contact Form",
      :to => Rails.application.config.contact_form_recipient,
      :from => %("#{name}" <#{email}>)
    }
  end
end