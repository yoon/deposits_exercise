require 'rails_helper'

RSpec.describe Deposit, type: :model do
  subject{ build(:deposit) }
  context "invalid" do
    it "if amount is < $0.01" do
      subject.amount = 0.00
      expect(subject).to be_invalid
    end
    it "if amount exceeds tradeline amount" do
      subject.amount = subject.tradeline.amount + 0.01
      expect(subject).to be_invalid
    end
    it "if amount exceeds tradeline balance" do
      tl = create(:tradeline)
      tl.deposits.create(amount: 0.02)

      subject.tradeline = tl
      subject.amount = subject.tradeline.amount
      expect(subject).to be_invalid
    end
  end
  context "valid" do
    it "if amount is under tradeline amount" do
      subject.amount = subject.tradeline.amount - 0.01
      expect(subject).to be_valid
    end
    it "if amount is under tradeline balance" do
      tl = create(:tradeline)
      tl.deposits.create(amount: 0.02)
      subject.tradeline = tl
      subject.amount = (tl.amount - 10.00)
      expect(subject).to be_valid
    end
  end
end
