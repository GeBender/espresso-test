class PasswordsController < Devise::PasswordsController
  def create
    check = User.find_by email: params[:user][:email]
    return send_not_found if check.nil?

    super
  end

  def send_not_found
    UserMailer.recovery_not_found(params[:user][:email]).deliver_now
    flash[:notice] = I18n.t(:send_instructions, scope: %i[devise passwords])
    redirect_to new_user_session_path
  end
end
