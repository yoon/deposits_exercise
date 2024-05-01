class Tradeline < ApplicationRecord
  has_many :deposits

  def balance
    amount - deposits.pluck(:amount).sum
  end

  def as_json(options={})
    super(only: [:id, :name, :amount],
            methods: [:balance])
  end
end
