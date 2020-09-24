require 'rails_helper'

RSpec.describe 'microposts', js: true, type: :system do
  let!(:user) { create(:user, email: 'test@micropost.com') }

  describe 'user create new micropost' do
    before :each do
      visit login_path
      fill_in 'メールアドレス', with: 'test@micropost.com'
      fill_in 'パスワード', with: 'password'
      click_button 'Log In'
      visit new_micropost_path
    end

    context 'created by valid values' do
      before do
        fill_in 'テキスト', with: 'テスト投稿'
        fill_in '場所・地名', with: '東京駅'
        page.find('#micropost_due_on').set('10-10-2019')
        click_button '投稿する'
      end

      it 'have success flash message' do
        expect(page).to have_content '投稿しました'
      end

      it 'is displayed' do
        click_on 'POST'
        expect(page).to have_content 'テスト投稿'
        expect(page).to have_content '東京駅'
        expect(page).to have_content '2019年10月10日'
      end
    end

    context 'created by invalid values' do
      it 'have alert flash messages' do
        click_button '投稿する'
        expect(page).to have_content 'The form contains 2 error.'
        expect(page).to have_content 'テキストを入力してください'
        expect(page).to have_content '場所・地名を入力してください'
      end
    end
  end
end
