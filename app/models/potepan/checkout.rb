class Potepan::Checkout < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX, message: 'が正しく入力されていません' }
  validates :postal, presence: true, length: { is: 7, message: 'は７桁の数字で入力してください' }
  VALID_STREET_ADDRESS_REGEX = /.+[都道府県].+[市区町村郡].+/
  validates :streetaddress, presence: true,
                            format: { with: VALID_STREET_ADDRESS_REGEX, message: "が正しく入力されていません" }
  VALID_PHONE_REGEX = /\A0[789]0\d{8}\z/
  validates :phone, presence: true, format: { with: VALID_PHONE_REGEX, message: "が正しく入力されていません" }
  validates :order_id, uniqueness: true
end
