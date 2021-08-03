class Vehicle < ApplicationRecord
  resourcify
  
  belongs_to :user
  has_many :replacement_requests


end
