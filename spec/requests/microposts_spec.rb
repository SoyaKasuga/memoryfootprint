require 'rails_helper'

RSpec.describe 'Micropost', type: :request do
  let!(:user) { create(:user) }

  describe 'GET #new' do
    it 'renders a successful response' do
      log_in_as(user)
      get new_micropost_path
      expect(response).to have_http_status 200
    end
  end

  describe 'GET #index' do
    it 'renders a successful response' do
      get microposts_path
      expect(response).to have_http_status 200
    end
  end

  describe 'GET #show' do
    let(:micropost) { create(:micropost) }
    it 'renders a successful response' do
      get micropost_path(micropost)
      expect(response).to have_http_status 200
    end
  end

  describe 'GET #rank' do
    it 'renders a successful response' do
      get microposts_rank_path
      expect(response).to have_http_status 200
    end
  end

  describe 'GET #search' do
    it 'renders a successful response' do
      get microposts_search_path
      expect(response).to have_http_status 200
    end
  end

  describe 'POST #create' do
    it 'create a micropost and redirect to user page' do
      log_in_as(user)
      post microposts_path, params: { micropost: { content: 'テスト',
                                                   address: '東京駅' } }
      expect(response).to redirect_to user_path(user)
    end
    it 'does not create a micropost while not logged in' do
      post microposts_path, params: { micropost: { content: 'テスト',
                                                   address: '東京駅' } }
      expect(response).to redirect_to login_path
    end
  end
  describe 'DELETE #destroy' do
    let!(:micropost) { create(:micropost, user: user) }

    it 'destroy a micropost' do
      log_in_as(user)
      delete micropost_path(micropost)
      expect(response).to redirect_to user_path(user)
    end
    it 'does not destroy a micropost while not logged in' do
      delete micropost_path(micropost)
      expect(response).to redirect_to login_path
    end
  end
end
