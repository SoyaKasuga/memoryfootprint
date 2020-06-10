require 'rails_helper'

RSpec.describe 'site layout', type: :system do
  context 'access to root_path' do
    before { visit root_path }
    subject { page }
    it 'has links' do
      is_expected.to have_link 'トップ', href: root_path
      is_expected.to have_link 'メモリー', href: users_path
      is_expected.to have_link '新規登録', href: signup_path
      is_expected.to have_link 'ログイン', href: login_path
    end
  end
end