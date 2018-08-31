require 'rails_helper'

RSpec.describe Potepan::CategoriesController, type: :controller do
  let(:taxon) { create(:taxon) }
  let(:taxonomy) { create(:taxonomy) }

  describe "showアクションに関するテスト" do
    it "正常にレスポンスを返すこと" do
      get :show, params: { id: taxon.id }
      expect(response).to be_success
    end

    it "ステータスコードが200のレスポンスを返すこと" do
      get :show, params: { id: taxon.id }
      expect(response). to have_http_status "200"
    end

    it "showアクション内の'@taxons'と作成した'taxon'が等しいか" do
      get :show, params: { id: taxon.id }
      puts assigns(:taxons).name
      puts taxon.name
      expect(assigns(:taxons)).to eq taxon
    end
  end
end
