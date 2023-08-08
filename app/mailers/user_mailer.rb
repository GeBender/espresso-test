class UserMailer < ApplicationMailer
  def recovery_not_found(to_email)
    mail(to: to_email, subject: I18n.t(:subject, scope: %i[devise mailer recovery_not_found]))
  end

  def send_two_factor_code(user, code)
    @user = user
    @code = code
    mail(to: @user.email, subject: 'Código de Autenticação')
  end
end
