class Potepan::Favorite < ApplicationRecord
  validates :user_id, presence: true, uniqueness: { scope: :product_id }
  validates :product_id, presence: true
  belongs_to :product, class_name: 'Spree::Product'
  belongs_to :user
end
