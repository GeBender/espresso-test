require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  fixtures :users

  controller do
    def index
      render plain: 'Hello, world!'
    end
  end

  describe 'authentication' do
    context 'when user is authenticated' do
      before do
        sign_in(users(:joe))
      end

      it 'allows access to index' do
        get :index
        expect(response).to have_http_status(:success)
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to sign in page' do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
