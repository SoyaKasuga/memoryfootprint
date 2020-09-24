require 'rails_helper'

RSpec.describe 'Sessions', type: :system do
  describe 'user create session' do
    let!(:user) { create(:user, email: 'loginuser@example.com', password: 'password') }
    before do
      visit login_path
    end
    context 'enter an valid values' do
      before do
        fill_in 'メールアドレス', with: 'loginuser@example.com'
        fill_in 'パスワード', with: 'password'
        click_button 'Log In'
      end
      subject { page }

      it 'have links while logged in', js: true do
        is_expected.to have_current_path user_path(user)
        find('.menu_single').hover
        is_expected.to have_link 'TOP', href: root_path
        is_expected.to have_link 'POSTS LIST', href: microposts_path
        is_expected.to have_link 'MAP', href: index_path
        is_expected.to have_link 'USERS LIST', href: users_path
        is_expected.to have_link user.name.to_s, href: user_path(user)
        is_expected.to have_link 'PROFILE', href: user_path(user)
        is_expected.to have_link 'EDIT YOUR PROFILE', href: edit_user_path(user)
        is_expected.to have_link 'POST', href: new_micropost_path
        is_expected.to have_link 'LOG OUT', href: logout_path
      end

      it 'log out after log in' do
        click_link 'LOG OUT'
        is_expected.to have_current_path root_path
        is_expected.to have_link 'TOP', href: root_path
        is_expected.to have_link 'POSTS LIST', href: microposts_path
        is_expected.to have_link 'MAP', href: index_path
        is_expected.to have_link 'USERS LIST', href: users_path
        is_expected.to have_link 'SIGN UP', href: signup_path
        is_expected.to have_link 'LOG IN', href: login_path
      end
    end

    context 'enter an invalid values' do
      before do
        fill_in 'メールアドレス', with: ''
        fill_in 'パスワード', with: ''
        click_button 'Log In'
      end
      subject { page }

      it 'gets an flash messages' do
        is_expected.to have_selector('.alert-danger', text: 'メールアドレスもしくはパスワードが正しくありません')
        is_expected.to have_current_path login_path
      end

      context 'access to other page' do
        before { visit root_path }
        it 'is flash disappear' do
          is_expected.to_not have_selector('.alert-danger', text: 'メールアドレスもしくはパスワードが正しくありません')
        end
      end
    end
  end
end
