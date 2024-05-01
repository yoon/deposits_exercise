require "rails_helper"

RSpec.describe DepositsController, type: :controller do
  let(:tradeline) { FactoryBot.create :tradeline_with_deposits }

  describe "#index" do
    it "shows deposits" do
      get :index, params: { tradeline_id: tradeline.id }
      body = JSON.parse(response.body)
      expect(body.size).to eq(tradeline.deposits.size)
    end
  end

  describe "#show" do
    it "shows a specific deposit" do
      get :show, params: { tradeline_id: tradeline.id, id: tradeline.deposits.first.id }
      body = JSON.parse(response.body)
      expect(body["id"]).to eq(tradeline.deposits.first.id)
    end
  end

  describe "#create" do
    it "creates specific deposit" do
      post :create, params: { tradeline_id: tradeline.id, deposit: { amount: 10.00, date: "2024-05-01" } }
      body = JSON.parse(response.body)
      expect(body["id"]).to be_present
      expect(body["tradeline_id"]).to eq(tradeline.id)
      expect(body["amount"]).to eq("10.0")
      # TODO format JSON
    end

    context "invalid" do
      it "shows an error if no deposit" do
        post :create, params: { tradeline_id: tradeline.id }
        body = JSON.parse(response.body)
        expect(body["error"]).to eq("param is missing or the value is empty: deposit")
      end

      it "shows an error if deposit exceeds balance" do
        post :create, params: { tradeline_id: tradeline.id, deposit: { amount: tradeline.balance + 0.01, date: "2024-05-01" } }
        body = JSON.parse(response.body)
        expect(body["error"]["amount"][0]).to eq("Must be less than tradeline balance")
      end
    end
  end
end
