require 'rails_helper'

RSpec.describe PasswordsController, type: :controller do
  fixtures :users

  describe 'remember' do
    context 'when email is not found' do
      it 'send specific e-mail without link' do
        @request.env['devise.mapping'] = Devise.mappings[:user]
        post :create, params: {
          user: {
            email: 'invalid@example.com'
          }
        }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when email is found' do
      it 'run super' do
        @request.env['devise.mapping'] = Devise.mappings[:user]
        post :create, params: {
          user: {
            email: 'test@example.com'
          }
        }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
