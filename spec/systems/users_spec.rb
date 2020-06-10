require 'rails_helper'

RSpec.describe 'users',js: true, type: :system do
  describe 'user create a new account' do
    context 'enter an valid values' do
      before do
        visit signup_path
        fill_in 'ユーザー名(10文字以内)', with: 'testuser'
        fill_in 'メールアドレス', with: 'testuser@example.com'
        fill_in 'パスワード(6文字以上)', with: 'password'
        fill_in 'パスワード(確認)', with: 'password'
        click_button 'アカウントを作成する'
      end
      it 'gets an flash message' do
        expect(page).to have_selector('.alert-success', text: "memoryfootprintへようこそ！")
      end
    end
    context 'enter an invalid values' do
      before do
        visit signup_path
        fill_in 'ユーザー名(10文字以内)', with: ''
        fill_in 'メールアドレス', with: ''
        fill_in 'パスワード(6文字以上)', with: ''
        fill_in 'パスワード(確認)', with: ''
        click_button 'アカウントを作成する'
      end
      subject { page }
      it 'get flash messages' do
        is_expected.to have_selector('#error_explanation')
        is_expected.to have_selector('.alert-danger', text: 'The form contains 4 error.')
        is_expected.to have_content("Nameを入力してください")
        is_expected.to have_content("Emailを入力してください")
        is_expected.to have_content("Passwordを入力してください")
      end
      it 'render to /signup url' do
        is_expected.to have_current_path '/signup'
      end
    end
  end
end