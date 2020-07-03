require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let!(:user) { create(:user) }
  let!(:another) { create(:user, name: 'another', email: 'another@another.com') }
  let!(:relationship) { user.active_relationships.build(followed_id: another.id) }

  it 'valid' do
    expect(relationship).to be_valid
  end

  describe 'follower/followed methods' do
    it { is_expected.to respond_to(:follower) }
    it { is_expected.to respond_to(:followed) }

    it 'follower method return following-user' do
      expect(relationship.follower). to eq user
    end

    it 'followed method return followed-user' do
      expect(relationship.followed). to eq another
    end
  end

  describe 'validation' do
    it { is_expected.to validate_presence_of(:follower_id) }
    it { is_expected.to validate_presence_of(:followed_id) }
  end
end
