# frozen_string_liteal: true

FactoryBot.define do
  factory :shop do
    sequence(:name) { |n| "Shop#{n}" }
    sequence(:ruc) { |n| "17#{n}" }
    phone1 { '0911111111' }
    address { 'test shop address' }
  end
end
