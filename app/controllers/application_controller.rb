class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  layout :set_layout

  def index; end

  private

  def set_layout
    return 'public' if [
      'sessions',
      'registrations',
      'unlocks',
      'passwords',
      'two_factor_authentication'
    ].include? controller_name

    'application'
  end
end
