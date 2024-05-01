class Deposit < ApplicationRecord
  belongs_to :tradeline

  validates :amount, comparison: { greater_than: 0.00 }
  validate :tradeline_amount
  private

  def tradeline_amount
    unless amount < self.tradeline.balance
      errors.add(:amount, 'Must be less than tradeline amount')
    end
  end
end
