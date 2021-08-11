class ReplacementProposal < ApplicationRecord
  resourcify
  
  belongs_to :user
  belongs_to :shop
  belongs_to :replacement_request

  validates :name, :price, :brand, :origin, :delivery_time, :conditions, presence: true

  scope :accepted, ->() {where(state: 'accepted')}
end
