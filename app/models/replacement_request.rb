class ReplacementRequest < ApplicationRecord
  resourcify
  
  belongs_to :user
  belongs_to :vehicle
end
