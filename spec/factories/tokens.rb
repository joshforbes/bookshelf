FactoryGirl.define do
  factory :token, class: Users::Token do
    user
    last_used_at DateTime.now
  end
end
