require 'rails_helper'

RSpec.describe Like, type: :model do
  let!(:user) { create(:user) }
  let!(:another) { create(:user, name: 'another', email: 'another@another.com') }
  let!(:micropost) { create(:micropost, user: another) }
  let!(:like) { user.likes.build(micropost: micropost) }

  it 'valid' do
    expect(like).to be_valid
  end

  describe 'validation' do
    it { is_expected.to validate_presence_of(:user_id) }
    it { is_expected.to validate_presence_of(:micropost_id) }
  end
end
