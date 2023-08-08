class UsersController < ApplicationController
  before_action :authenticate_user!
  layout 'application'

  def password; end

  def mfa
    if current_user.otp_secret_key
      render 'users/cancel_mfa'
    else
      current_user.otp_secret_key = current_user.generate_totp_secret
      @qr_code = current_user.provisioning_uri
    end
  end

  def cancel_mfa
    current_user.otp_secret_key = nil
    current_user.save

    flash[:success] = 'Autenticação de dois fatores CANCELADA com sucesso!'
    redirect_to root_path
  end

  def update_mfa
    current_user.otp_secret_key = params[:otp_secret_key]
    if current_user.authenticate_otp params[:otp_attempt]
      current_user.save
      flash[:success] = 'Autenticação de dois fatores ativada com sucesso!'
      redirect_to root_path
    else
      flash[:warning] = 'Código não confere'
      redirect_to mfa_path
    end
  end

  def update_password
    if current_user.update(user_params)
      flash[:success] = I18n.t(:success, scope: %i[pages password messages])

      bypass_sign_in(current_user)
      redirect_to root_path
    else
      render 'users/password'
    end
  end

  private

  def user_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end
end
