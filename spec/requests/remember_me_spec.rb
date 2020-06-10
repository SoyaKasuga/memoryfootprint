require 'rails_helper'

RSpec.describe 'Remember me', type: :request do
  let!(:user) { create(:user) }
  context 'remembering' do
    before do
       post login_path, params: { session: { email: user.email,
                                              password: user.password,
                                              remember_me: '1'} }
    end
    
    it 'login with remembering' do
      expect(response.cookies['remember_token']).to_not eq nil 
    end
    it 'log out and discard remember token' do
      delete logout_path
      expect(response).to redirect_to root_path
      expect(cookies['remember_token']).to eq ""
    end
  end
  context 'not remembering' do
    it 'login without remambering' do
      log_in_as(user)
      expect(response.cookies['remember_token']).to eq nil
    end
  end
  
end