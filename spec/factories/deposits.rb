FactoryBot.define do
  factory :deposit do
    deposit_on { "2024-05-01" }
    amount { "9.99" }
    tradeline { nil }
  end
end
