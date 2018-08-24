require 'rails_helper'

RSpec.describe Potepan::ProductsController, type: :controller do

    let(:product) { create(:product) }

    describe "showアクションに関するテスト" do
      it "リクエストが成功し、レスポンスは成功しているか" do
        get :show, params: { id: product.id}
        expect(response).to have_http_status(:success)
      end
    end

end
