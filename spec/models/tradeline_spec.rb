require 'rails_helper'

RSpec.describe Tradeline, type: :model do
  subject{ create(:tradeline, amount: 20.00) }

  context "with deposits" do
    before do
      subject.deposits.create(amount: 10.00, deposit_on: 1.day.from_now)
      subject.deposits.create(amount: 5.00, deposit_on: 1.day.from_now)
    end

    it "calculates balance" do
      expect(subject.balance).to eq(5.00)
    end
  end
end
