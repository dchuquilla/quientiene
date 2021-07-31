class Vehicle < ApplicationRecord
  belongs_to :user
  has_many :replacement_requests


end
