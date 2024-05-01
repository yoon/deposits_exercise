class Tradeline < ApplicationRecord
  has_many :deposits

  def balance
    amount - deposits.pluck(:amount).sum
  end
end
