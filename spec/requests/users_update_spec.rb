require 'rails_helper'

RSpec.describe 'POST #update', type: :request do
  let!(:user) { create(:user) }
  before :each do
    post login_path, params: { session: { email: user.email,
                                          password: user.password } }
  end
  context 'valid request' do
    it 'edit user information' do
      patch user_path(user), params: { user: { name: 'valid',
                                               email: user.email,
                                               password: '',
                                               password_confirmation: '' } }
      expect(response).to redirect_to user_path(user)
      user.reload
      expect(user.name).to eq 'valid'
    end
  end
  context 'invalid request' do
    it 'does not edit user information' do
      patch user_path(user), params: { user: { name: 'a',
                                               email: 'a',
                                               password: 'a',
                                               password_confirmation: 'a' } }
      user.reload
      expect(user.name).to_not eq 'a'
    end
  end
end
