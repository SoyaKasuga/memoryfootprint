require 'rails_helper'

RSpec.describe 'map', js: true, type: :system do
  let!(:user) { create(:user, email: 'test@micropost.com', password: 'password') }

  describe 'login and visit map page' do
    before do
      visit login_path
      fill_in 'メールアドレス', with: 'test@micropost.com'
      fill_in 'パスワード', with: 'password'
      click_button 'ログイン'
      visit new_micropost_path
      fill_in 'テキスト', with: 'テスト投稿'
      fill_in '場所・地名', with: '東京駅'
      page.find('#micropost_due_on').set('10-10-2019')
      click_button '投稿する'
      visit index_path
      sleep 1
    end

    it 'display googlemap' do
      expect(page).to have_selector '.gm-style'
    end

    it 'display pin in googlemap' do
      find('map#gmimap0 area', visible: false).click
      expect(page).to have_content 'テストユーザー'
      expect(page).to have_content 'テスト投稿'
    end

    it 'jump user page when click' do
      find('map#gmimap0 area', visible: false).click
      find('div.infobox-user a').click
      expect(current_path).to eq user_path(user)
    end
  end
end