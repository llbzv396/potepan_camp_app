FactoryGirl.define do
  factory :potepan_user, class: 'Potepan::User' do
    sequence(:name) { |n| "test_user#{n}" }
    sequence(:email) { |n| "test_#{n}@example.com" }
    password "foobar"
    postal '1670034'
    phone '08029953914'
    streetaddress '東京都杉並区桃井1-34-5'
  end
end
