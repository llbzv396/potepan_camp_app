class Potepan::User < ApplicationRecord
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  validates :postal, length: { is: 7, message: 'は７桁の数字で入力してください' }, allow_nil: true
  VALID_PHONE_REGEX = /\A0[789]0\d{8}\z/
  validates :phone, format: { with: VALID_PHONE_REGEX, message: "が正しく入力されていません" },
                    allow_nil: true
  VALID_STREET_ADDRESS_REGEX = /.+[都道府県].+[市区町村郡].+/
  validates :streetaddress, presence: true,
                            format: { with: VALID_STREET_ADDRESS_REGEX, message: "が正しく入力されていません" },
                            allow_nil: true
end
