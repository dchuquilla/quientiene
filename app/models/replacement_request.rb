class ReplacementRequest < ApplicationRecord
  resourcify
  
  belongs_to :user
  belongs_to :vehicle
  has_many :replacement_proposals
  has_many_attached :photos

  validates :short_name, presence: true

  scope :pending, ->() {where(state: 'created')}
  scope :closed, ->() {where(state: 'closed')}
  scope :answered, ->() {where(state: 'answered')}
end
