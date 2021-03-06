require 'rails_helper'

RSpec.describe 'POST #create', type: :request do
  context 'valid request' do
    it 'adds a user' do
      expect do
        post signup_path, params: { user: attributes_for(:user) }
      end.to change(User, :count).by(1)
    end
    context 'adds a user' do
      before { post signup_path, params: { user: attributes_for(:user) } }
      subject { response }
      it { is_expected.to redirect_to user_path(User.last) }
      it { is_expected.to have_http_status 302 }
    end
  end

  context 'invalid request' do
    let(:user_params) do
      attributes_for(:user, name: '',
                            email: 'user@invalid',
                            password: '',
                            password_confirmation: '')
    end
    it 'does not add a user' do
      expect do
        post signup_path, params: { user: user_params }
      end.to change(User, :count).by(0)
    end
  end
end
