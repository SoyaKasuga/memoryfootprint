FactoryBot.define do
  factory :micropost do
    content { "#{'a' * 140}" }
    address { "東京駅" }
    user
  end
end