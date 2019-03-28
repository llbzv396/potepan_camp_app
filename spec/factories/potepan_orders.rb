FactoryGirl.define do
  factory :potepan_order, class: 'Potepan::Order' do
    number 1
    item_total 1
    total_price 1
    state "MyText"
  end
end
