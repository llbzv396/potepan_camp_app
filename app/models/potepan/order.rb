class Potepan::Order < ApplicationRecord
  belongs_to :user
  belongs_to :checkout
  has_many :ordered_products
end
