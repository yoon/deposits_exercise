# frozen_string_literal: true

FactoryBot.define do
  factory :tradeline do
    name { 'Some Credit Card' }
    amount { 3223.54 }

    factory :tradeline_with_deposits do
      transient do
        deposits_count { 3 }
      end

      after(:create) do |tradeline, evaluator|
        create_list(:deposit, evaluator.deposits_count, tradeline: tradeline)
        tradeline.reload
      end
    end
  end


end
