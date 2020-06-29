require 'rails_helper'

RSpec.describe 'users update', js: true, type: :system do
  let!(:user) { create(:user, email: 'test@update.com', password: 'password', admin: true) }
  let!(:another) { create(:user, name: 'another', email: 'another@another.com') }

  describe 'edit own profile' do
    before  :each do
      visit login_path
      fill_in 'メールアドレス', with: 'test@update.com'
      fill_in 'パスワード', with: 'password'
      click_button 'ログイン'
      visit user_path(user)
    end

    context 'user edit own profile' do
      before do
        click_on '編集する'
        fill_in '名前', with: 'アップデート'
        fill_in 'メールアドレス', with: 'update@update.com'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード(確認)', with: 'password'
        fill_in '自己紹介文(100文字以内)', with: '自己紹介文'
        click_on '変更する'
      end

      it 'have success flash message' do
        expect(page).to have_content 'プロフィールを更新しました'
      end

      it 'confirm change own profile' do
        expect(page).to have_selector('.name', text: 'アップデート')
        expect(page).to have_text('自己紹介文')
        click_on '編集する'
        expect(page).to have_field '名前', with: 'アップデート'
        expect(page).to have_field 'メールアドレス', with: 'update@update.com'
      end

      it 'edit profile without fill in password' do
        click_on '編集する'
        fill_in '名前', with: 'アップデート２'
        click_on '変更する'
        expect(page).to have_selector('.name', text: 'アップデート２')
      end
    end
  end
end
