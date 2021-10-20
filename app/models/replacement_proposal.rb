# frozen_string_literal: true

class ReplacementProposal < ApplicationRecord
  resourcify

  belongs_to :user
  belongs_to :shop
  belongs_to :replacement_request

  has_many_attached :photos

  validates :name, :price, :brand, :origin, :delivery_time, :conditions, presence: true

  scope :accepted, -> { where(state: 'accepted') }
  scope :recent, ->(number) { order(id: :desc).limit(number) }
end
