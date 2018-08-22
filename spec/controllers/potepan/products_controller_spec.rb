require 'rails_helper'

RSpec.describe Potepan::ProductsController, type: :controller do

    let(:product) { FactoryGirl.create(:product) }

    describe "showアクションに関するテスト" do
      it "getアクションが反応するか" do
        get :show, params: { id: product.id}
        expect(response).to have_http_status(:success)
      end
    end

end
