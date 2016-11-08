require "mandrill"

class MandrillDeviseMailer < Devise::Mailer
  default(
    from: ENV.fetch("email_from"),
    reply_to: ENV.fetch("email_reply_to")
  )

  def new_registration(user)
    subject = "Este es tu código de postulante y turno para exámenes"
    merge_vars = {
      FNAME: user.profile.name || user.email,
      CPOSTULANTE: user.code,
      TEXAMEN: user.profile.spot.name,
      BRANCH_ADDRESS: user.branch.address
    }

    body = mandrill_template("admission-success-template",merge_vars)
    send_mail(user.email,subject,body)
  end

  def reset_password_instructions(record, token, opts={})
    subject = "Instrucciones para reiniciar tu password"

    merge_vars = {
      "PASSWORD_RESET_LINK" => "https://#{MandrillDeviseMailer.default_url_options[:host]}/users/password/edit?reset_password_token=#{token}",
      "DISPLAY_NAME" => record.name || record.email
    }

    body = mandrill_template("password-reset-template", merge_vars)
    send_mail(record.email, subject, body)
  end

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
