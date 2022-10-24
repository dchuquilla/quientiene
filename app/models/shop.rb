# frozen_string_literal: true

# Shops keep informatios for business, it shiuld be defined with country and location information
class Shop < ApplicationRecord
  resourcify
  belongs_to :user
  has_many :replacement_proposals

  validates :name, :address, :ruc, :phone1, presence: true
  validates :ruc, format: { with: /\A\d+\z/, message: 'solo admite números' }
  validates :ruc, uniqueness: true
  validates :phone1, format: { with: /09([0-9]{8})+/, message: 'no es correcto ' }

  scope :recent, ->(number) { order(id: :desc).limit(number) }
end
