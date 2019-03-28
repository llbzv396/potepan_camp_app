class Potepan::Checkout < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true
  validates :postal, presence: true
  validates :streetaddress, presence: true
  validates :phone, presence: true
  validates :order_id, uniqueness: true
end
