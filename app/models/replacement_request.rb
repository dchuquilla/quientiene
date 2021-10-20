# frozen_string_literal: true

class ReplacementRequest < ApplicationRecord
  resourcify

  belongs_to :user
  belongs_to :vehicle
  has_many :replacement_proposals
  has_many_attached :photos

  validates :short_name, :country, :state_province, :city, presence: true

  scope :pending, -> { where(state: %w[created answered]) }
  scope :closed, -> { where(state: 'closed') }
  scope :answered, -> { where(state: 'answered') }
  scope :recent, ->(number) { order(id: :desc).limit(number) }
end
