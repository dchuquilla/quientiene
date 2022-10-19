# frozen_string_literal: true

FactoryBot.define do
  factory :vehicle do
    brand { 'Ford' }
    model { 'Bronco' }
    year { 2023 }
  end
end
