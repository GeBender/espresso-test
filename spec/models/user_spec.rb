require 'rails_helper'

RSpec.describe User, type: :model do
  fixtures :users

  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should validate_length_of(:password).is_at_least(12).is_at_most(32) }

  describe '#password_complexity' do
    before do
      @user = users(:joe)
    end
    it 'is valid with a complex password' do
      expect(@user).to be_valid
    end

    it 'is invalid with simple passwords' do
      @user.password = '123'
      expect(@user).to_not be_valid
    end

    it '#validate_password confirmation' do
      @user.password = '1234567890aA#'
      @user.password_confirmation = '1234567890aA'
      expect(@user).to_not be_valid

      @user.password_confirmation = '1234567890aA#'
      expect(@user).to be_valid
    end

    it '#validate_previous_password' do
      @user.current_password = '123456789aA###'
      @user.password = '123456789aA0#'
      @user.password_confirmation = '123456789aA0#'
      expect(@user).to_not be_valid
    end
  end
end
