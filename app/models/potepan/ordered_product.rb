class Potepan::OrderedProduct < ApplicationRecord
  belongs_to :order
  validates :order_id, uniqueness: { scope: :product_id }
end
