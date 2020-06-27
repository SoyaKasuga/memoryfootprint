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
        click_button 'ログイン'
      end
      subject { page }
      
      it 'have links while logged in', js: true do
        is_expected.to have_current_path user_path(user)
        find('.menu_single').hover
        is_expected.to have_link 'トップ', href: root_path
        is_expected.to have_link '全ての投稿', href: microposts_path
        is_expected.to have_link '地図', href: index_path
        is_expected.to have_link 'ユーザーリスト', href: users_path
        is_expected.to have_link "#{user.name}", href: user_path(user)
        is_expected.to have_link 'プロフィール', href: user_path(user)
        is_expected.to have_link 'ユーザー情報編集', href: edit_user_path(user)
        is_expected.to have_link '投稿する', href: new_micropost_path
        is_expected.to have_link 'ログアウト', href: logout_path
      end

      it 'log out after log in' do
        click_link 'ログアウト'
        is_expected.to have_current_path root_path
        is_expected.to have_link 'トップ', href: root_path
        is_expected.to have_link '全ての投稿', href: microposts_path
        is_expected.to have_link '地図', href: index_path
        is_expected.to have_link 'ユーザーリスト', href: users_path
        is_expected.to have_link '新規登録', href: signup_path
        is_expected.to have_link 'ログイン', href: login_path
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