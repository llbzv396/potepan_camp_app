require 'rails_helper'

RSpec.describe Potepan::User, type: :model do
  describe "新規登録に関するテスト" do
    it "正しいデータを入力すれば登録できること" do
      user = FactoryGirl.build(:potepan_user)
      expect(user).to be_valid
    end
    describe "名前のバリデーション" do
      it "名前がなければ登録できないこと" do
        user = FactoryGirl.build(:potepan_user, name: nil)
        expect(user).not_to be_valid
      end
      it "50文字以上の名前は登録できないこと" do
        user = FactoryGirl.build(:potepan_user, name: 'a' * 51)
        expect(user).not_to be_valid
      end
    end

    describe "メールアドレスのバリデーション" do
      it "メールアドレスがなければ登録できないこと" do
        user = FactoryGirl.build(:potepan_user, email: nil)
        expect(user).not_to be_valid
      end
      it "255文字以上のメールアドレスでは登録できないこと" do
        user = FactoryGirl.build(:potepan_user, email: "#{'a' * 244}@example.com")
        expect(user).not_to be_valid
      end
      it "重複したメールアドレスは登録できないこと" do
        FactoryGirl.create(:potepan_user, email: 'dup@example.com')
        user = FactoryGirl.build(:potepan_user, email: 'dup@example.com')
        expect(user).not_to be_valid
      end
      it "正しいフォーマットなら登録できること" do
        valid_addresses = %w(
          user@example.com USER@foo.COM A_US-ER@foo.bar.org
          first.last@foo.jp alice+bob@baz.cn
        )
        valid_addresses.each do |valid_address|
          user = FactoryGirl.build(:potepan_user, email: valid_address)
          expect(user).to be_valid
        end
      end
      it "指定したフォーマット以外では登録できないこと" do
        invalid_addresses = %w(
          user@example,com user_at_foo.org user.name@example.
          foo@bar_baz.com foo@bar+baz.com foo@bar..com
        )
        invalid_addresses.each do |invalid_address|
          user = FactoryGirl.build(:potepan_user, email: invalid_address)
          expect(user).not_to be_valid
        end
      end
    end

    describe "パスワードのバリデーション" do
      it "パスワードがなければ登録できないこと" do
        user = FactoryGirl.build(:potepan_user, password: nil)
        expect(user).not_to be_valid
      end
      it "6文字以下では登録できないこと" do
        user = FactoryGirl.build(:potepan_user, password: 'abcde')
        expect(user).not_to be_valid
      end
    end
  end

  describe "登録情報変更に関するテスト" do
    describe "郵便番号に関するバリデーション" do
      it "入力されていなければ編集できないこと" do
        user = FactoryGirl.build(:potepan_user, postal: '')
        expect(user).not_to be_valid
      end
      it "半角数字7桁なら登録できること" do
        valid_postal_list = %w(1234567 8674938 0293018 0098431)
        valid_postal_list.each do |postal|
          user = FactoryGirl.build(:potepan_user, postal: postal)
          expect(user).to be_valid
        end
      end
      it "半角数字7桁以外で登録できないこと" do
        invalid_postal_list = %w(123456 12345678 092-4059 091-029492)
        invalid_postal_list.each do |postal|
          user = FactoryGirl.build(:potepan_user, postal: '12345678')
          expect(user).not_to be_valid
        end
      end
    end

    describe "電話番号に関するバリデーション" do
      it "入力されていなければ編集できないこと" do
        user = FactoryGirl.build(:potepan_user, phone: '')
        expect(user).not_to be_valid
      end
      it "指定したフォーマットなら登録できること" do
        valid_phone_numbers = %w(09087019032 08029953914 07095847361)
        valid_phone_numbers.each do |phone|
          user = FactoryGirl.build(:potepan_user, phone: phone)
          expect(user).to be_valid
        end
      end
      it "指定したフォーマット以外では登録できないこと" do
        invalid_phone_numbers = %w(090059483914 0809584738 05049850981)
        invalid_phone_numbers.each do |phone|
          user = FactoryGirl.build(:potepan_user, phone: phone)
          expect(user).not_to be_valid
        end
      end
    end

    describe "住所に関するバリデーション" do
      it "入力されていなければ編集できないこと" do
        user = FactoryGirl.build(:potepan_user, streetaddress: '')
        expect(user).not_to be_valid
      end
      it "指定したフォーマットなら登録できること" do
        valid_street_addresses = %w(
          東京都新宿区西新宿2丁目8-1
          大阪府大阪市中央区大手前2丁目大阪府庁本館5階
          北海道札幌市中央区北3条西6丁目
          徳島県徳島市万代町1丁目1
        )
        valid_street_addresses.each do |address|
          user = FactoryGirl.build(:potepan_user, streetaddress: address)
          expect(user).to be_valid
        end
      end
      it "指定したフォーマット以外では登録できないこと" do
        invalid_street_addresses = %w(
          新宿区西新宿2丁目8-1
          大阪市中央区大手前2丁目大阪府庁本館5階
          大阪府
          東京都
        )
        invalid_street_addresses.each do |address|
          user = FactoryGirl.build(:potepan_user, streetaddress: address)
          expect(user).not_to be_valid
        end
      end
    end
  end
end
