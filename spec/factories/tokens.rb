FactoryGirl.define do
  factory :token do
    expires_at "2017-05-08 21:25:10"
    association :user, factory: :user
  end
end
