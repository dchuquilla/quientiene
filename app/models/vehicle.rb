class Vehicle < ApplicationRecord
  resourcify
  
  belongs_to :user
  has_many :replacement_requests

  validates :brand, :model, :year, presence: true
  validates :year, format: { with: /\A[0-9]+\z/, message: "solo admite números" }

  scope :recent, ->(number) { order(id: :desc).limit(number) }
  scope :all_brands, ->() { distinct(:brand).select(:brand).to_a.map{ |v| v['brand'] } }
  scope :all_years, ->() { distinct(:year).select(:year).to_a.map{ |v| v['year'] } }

end
