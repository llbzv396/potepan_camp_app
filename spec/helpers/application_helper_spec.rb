require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "full_titleメソッドに関するテスト" do
    context "page_titleが空の場合" do
      let(:page_title) { '' }

      it "full_titleが[BIGBAG Store]となる事" do
        expect(full_title(page_title)).to eq "BIGBAG Store"
      end
    end

    context "page_titleがRuby on Railsの場合" do
      let(:page_title) { 'Ruby on Rails' }

      it "full_titleが[Ruby on Rails - BIGBAG Store]となる事" do
        expect(full_title(page_title)).to eq "Ruby on Rails - BIGBAG Store"
      end
    end
  end
end
