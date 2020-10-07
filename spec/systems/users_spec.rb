require 'rails_helper'

RSpec.describe 'users', js: true, type: :system do
  describe 'POST #create' do
    context 'enter an valid values' do
      before do
        visit signup_path
        fill_in 'ユーザー名（10文字以内）', with: 'test'
        fill_in 'メールアドレス', with: 'testuser@example.com'
        fill_in 'パスワード（6文字以上）', with: 'password'
        fill_in 'パスワード（確認）', with: 'password'
        click_button 'Create Your Account'
      end
      it 'gets an flash message' do
        expect(page).to have_selector('.alert-success', text: 'memoryfootprintへようこそ！')
      end
    end
    context 'enter an invalid values' do
      before do
        visit signup_path
        fill_in 'ユーザー名（10文字以内）', with: ''
        fill_in 'メールアドレス', with: ''
        fill_in 'パスワード（6文字以上）', with: ''
        fill_in 'パスワード（確認）', with: ''
        click_button 'Create Your Account'
      end
      subject { page }
      it 'get flash messages' do
        is_expected.to have_selector('#error_explanation')
        is_expected.to have_selector('.alert-danger', text: 'The form contains 4 error.')
        is_expected.to have_content('名前を入力してください')
        is_expected.to have_content('メールアドレスを入力してください')
        is_expected.to have_content('パスワードを入力してください')
      end
      it 'render to /signup url' do
        is_expected.to have_current_path '/signup'
      end
    end
  end

  describe 'POST #destroy' do
    let!(:user) { create(:user, email: 'test@test.com', password: 'password', admin: true) }
    let!(:another) { create(:user, name: 'another', email: 'another@another.com') }

    context 'admin user' do
      before do
        visit login_path
        fill_in 'メールアドレス', with: 'test@test.com'
        fill_in 'パスワード', with: 'password'
        click_button 'Log In'
        visit user_path(another)
      end

      it do
        delete_link = find_link '削除'
        page.accept_confirm '削除してよろしいですか？' do
          delete_link.click
        end
        expect(page).to have_content 'ユーザーを削除しました'
        expect(User.where(email: 'another@another.com')).to be_empty
      end
    end

    context 'non-admin user cannot' do
      before do
        visit login_path
        fill_in 'メールアドレス', with: 'another@another.com'
        fill_in 'パスワード', with: 'password'
        click_button 'Log In'
        visit user_path(user)
      end

      it do
        expect(page).to have_no_content '削除'
      end
    end
  end

  describe 'GET #index' do
    let!(:user) { create(:user, email: 'test@test.com', password: 'password', admin: true) }
    let!(:another) { create(:user, name: 'another', email: 'another@another.com') }
    before { visit users_path }

    it 'have user path' do
      expect(page).to have_link 'テストユーザー', href: user_path(user)
    end
  end

  describe 'GET #show' do
    let!(:user) { create(:user, email: 'test@test.com', password: 'password', admin: true) }
    let!(:another) { create(:user, name: 'another', email: 'another@another.com') }
    before do
      visit login_path
      fill_in 'メールアドレス', with: 'test@test.com'
      fill_in 'パスワード', with: 'password'
      click_button 'Log In'
    end

    context 'visit own user page' do
      before { visit user_path(user) }

      it 'have edit link' do
        expect(page).to have_link '編集する', href: edit_user_path(user)
      end
    end

    context 'visit another user page', js: true do
      before { visit user_path(another) }

      it 'have follow link' do
        expect(page).to have_button 'フォローする'
      end
    end
  end

  describe 'edit own profile' do
    let!(:user) { create(:user, email: 'test@update.com', password: 'password', admin: true) }
    let!(:another) { create(:user, name: 'another', email: 'another@another.com') }
    before  :each do
      visit login_path
      fill_in 'メールアドレス', with: 'test@update.com'
      fill_in 'パスワード', with: 'password'
      click_button 'Log In'
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
