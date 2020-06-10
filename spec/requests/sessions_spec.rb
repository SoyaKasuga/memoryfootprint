require 'rails_helper'

RSpec.describe 'access to sessions', type: :request do
  let!(:user) { create(:user) }
  describe 'POST #create' do
    it 'log in and resirect to user page' do
      log_in_as(user)
      expect(response).to redirect_to user_path(user)
      expect(is_logged_in?).to be_truthy
    end
    it 'does not log in because of invalid request' do
      post login_path, params: { session: { email: "",
                                            password: "" } }
      expect(is_logged_in?).to be_falsey
    end
  end
  describe 'DELETE #destroy' do
    it 'log out and redirect to root page' do
      log_in_as(user)
      delete logout_path
      expect(response).to redirect_to root_path
      expect(is_logged_in?).to be_falsey
    end
    it 'log out while not logged in' do
      delete logout_path
      expect(response).to redirect_to root_path
    end
  end
end