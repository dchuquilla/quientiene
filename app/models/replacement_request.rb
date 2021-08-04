class ReplacementRequest < ApplicationRecord
  resourcify
  
  belongs_to :user
  belongs_to :vehicle

  validates :short_name, presence: true
end
