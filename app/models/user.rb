class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable,
         :lockable, :timeoutable, :two_factor_authenticatable

  validate :password_complexity
  validate :validate_new_password, if: :password_required?

  attr_accessor :current_password, :password_confirmation, :code

  has_one_time_password(encrypted: true)

  def send_two_factor_authentication_code(code)
    UserMailer.send_two_factor_code(self, code).deliver_now
  end

  def update_attributes(attributes)
    self.attributes = attributes
    save
  end

  private

  def password_complexity
    return if password.blank?
    return if password.match?(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()\-_=+{};:,<.>]).{12,32}$/)

    errors.add :password, I18n.t(:bad_password, scope: %i[models users errors])
  end

  def validate_new_password
    validate_current_password
    validate_new_same_current_password
    validate_confirmed_new_password
  end

  def validate_current_password
    right = Devise::Encryptor.compare(self.class, encrypted_password_was, current_password)
    errors.add(:password, I18n.t(:wrong_password, scope: %i[models users errors])) unless right || !current_password
  end

  def validate_new_same_current_password
    same = Devise::Encryptor.compare(self.class, encrypted_password_was, password)
    errors.add(:password, I18n.t(:same_password, scope: %i[models users errors])) if same
  end

  def validate_confirmed_new_password
    confirmed = password == password_confirmation
    errors.add(:password, I18n.t(:diff_passwords, scope: %i[models users errors])) unless confirmed
  end
end
