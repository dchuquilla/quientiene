class Vehicle < ApplicationRecord
  resourcify
  
  belongs_to :user
  has_many :replacement_requests

  validates :plate, :brand, :model, :year, presence: true
  validates :year, format: { with: /\A[0-9]+\z/, message: "solo admite números" }

end
