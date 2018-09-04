require 'rails_helper'

RSpec.describe ApplicationHelper do
  include ApplicationHelper
  let(:page_title) { 'Ruby on Rails' }

  describe "full_titleメソッドに関するテスト" do
    it "page_titleが空の場合" do
      page_title = ''
      expect(full_title(page_title)).to eq "BIGBAG Store"
    end

    it "page_titleがRuby on Railsの場合" do
      expect(full_title(page_title)).to eq "Ruby on Rails - BIGBAG Store"
    end
  end
end
