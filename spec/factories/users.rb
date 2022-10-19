# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@ien.com" }
    password { 'Test123' }
  end
end
