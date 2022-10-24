# frozen_string_literal: true

class Vehicle < ApplicationRecord
  resourcify

  belongs_to :user
  has_many :replacement_requests

  validates :brand, :model, :year, presence: true
  validates :year, numericality: { only_integer: true }

  scope :recent, ->(number) { order(id: :desc).limit(number) }
  scope :all_brands, -> { distinct(:brand).select(:brand).to_a.map { |v| v['brand'] } }
  scope :all_years, -> { distinct(:year).select(:year).to_a.map { |v| v['year'] } }
end
