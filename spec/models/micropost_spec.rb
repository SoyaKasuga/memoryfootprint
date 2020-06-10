require 'rails_helper'

RSpec.describe Micropost, type: :model do
  let!(:user) { create(:user) }
  let!(:micropost){ create(:micropost,user: user) }
  
  it 'has a valid factory bot' do
    expect(micropost).to be_valid
  end
  it "user method return owner of microposts" do
    expect(micropost.user).to eq user
  end
  describe 'validations' do
    it { is_expected.to validate_presence_of(:user_id) }
    it { is_expected.to validate_presence_of(:content) }
    it { is_expected.to validate_presence_of(:address) }
    it { is_expected.to validate_length_of(:content).is_at_most(140) }
    it { is_expected.to validate_length_of(:address).is_at_most(30) }
  end
  it 'geocoder sets LatLng' do
    expect(micropost.latitude).to_not eq nil
    expect(micropost.longitude).to_not eq nil
  end
  
  describe "micropost association" do
    let!(:new_post) { create(:micropost,user: user) }
    
    it "order descending" do
      expect(user.microposts.count).to eq 2
      expect(Micropost.all.count).to eq user.microposts.count
      expect(user.microposts.to_a).to eq [new_post, micropost]
    end
  end
end