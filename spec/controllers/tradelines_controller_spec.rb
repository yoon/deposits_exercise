require "rails_helper"

RSpec.describe TradelinesController, type: :controller do
  describe "#index" do
    it "shows tradelines" do
      get :index
      body = JSON.parse(response.body)
      expect(body.size).to eq(Tradeline.count)
    end
  end

  describe "#show" do
    let(:tradeline) { FactoryBot.create :tradeline }

    it "shows a specific tradeline" do
      get :show, params: { id: tradeline.id }
      body = JSON.parse(response.body)
      expect(body["id"]).to eq(tradeline.id)
    end

    it "with a balance" do
      get :show, params: { id: tradeline.id }
      body = JSON.parse(response.body)
      balance = "%.2f" % tradeline.balance
      expect(body["balance"]).to eq(balance)
    end

    context "if the tradeline is not found" do
      it "responds with a 404" do
        get :show, params: { id: 1000 }
        expect(response).to have_http_status(:not_found)
      end
    end

    context "with deposits" do
      let(:tradeline_with_deposits) { FactoryBot.create :tradeline_with_deposits }
      it "has a balance" do
        get :show, params: { id: tradeline_with_deposits.id }
        body = JSON.parse(response.body)
        balance = "%.2f" % tradeline_with_deposits.balance
        expect(body["balance"]).to eq(balance)
      end
    end
  end
end
