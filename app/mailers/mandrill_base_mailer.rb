require "mandrill"

class MandrillBaseMailer < ActionMailer::Base
  default(
    from: ENV.fetch("email_from"),
    reply_to: ENV.fetch("email_reply_to")
  )

  private

  def send_mail(email, subject, body)
    mail(to: email, subject: subject, body: body, content_type: "text/html")
  end

  def mandrill_template(template_name, attributes)
    mandrill = Mandrill::API.new(ENV.fetch("smtp_password"))

    merge_vars = attributes.map do |key, value|
      { name: key, content: value }
    end

    mandrill.templates.render(template_name, [], merge_vars)["html"]
  end
end
