FactoryGirl.define do
  factory :my_poll do
    association :user, factory: :user
    expires_at "2017-05-28 20:48:38"
    title "MyStringSurvey"
    description "MyText test test et tes tes tes test"
  end
end
