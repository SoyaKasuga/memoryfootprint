require 'rails_helper'

RSpec.describe 'Sessions', type: :system do
  describe 'user create session' do
    before do
      visit login_path
    end
    context 'enter an valid values' do
      let!(:user) { create(:user, email: 'loginuser@example.com', password: 'password') }
      before do
        fill_in 'メールアドレス', with: 'loginuser@example.com'
        fill_in 'パスワード', with: 'password'
        click_button 'ログイン'
      end
      subject { page }
      it 'log in' do
        is_expected.to have_current_path user_path(user)
        is_expected.to_not have_link 'ログイン', href: login_path
        is_expected.to have_link 'ユーザー', href: user_path(user)
        is_expected.to have_link 'ログアウト', href: logout_path
      end
      it 'log out after log in' do
        click_link 'ログアウト'
        is_expected.to have_current_path root_path
        is_expected.to have_link 'ログイン', href: login_path
        is_expected.to_not have_link 'ログアウト', href: logout_path
        is_expected.to_not have_link 'ユーザー', href: user_path(user)
      end
    end
    context 'enter an invalid values' do
      before do
        fill_in 'メールアドレス', with: ''
        fill_in 'パスワード', with: ''
        click_button 'ログイン'
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