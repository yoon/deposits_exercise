class Deposit < ApplicationRecord
  belongs_to :tradeline

  validates :amount, comparison: { greater_than: 0.00 }
  validate :tradeline_amount

  def as_json(options={})
    super(only: [:id, :tradeline_id, :deposit_on, :amount])
  end

  private

  def tradeline_amount
    unless amount < self.tradeline.balance
      errors.add(:amount, 'Must be less than tradeline balance')
    end
  end
end
