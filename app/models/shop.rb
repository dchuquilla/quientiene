class Shop < ApplicationRecord
  resourcify
  belongs_to :user
  has_many :replacement_proposals

  validates :name, :address, :ruc, :phone1, presence: true
  validates :ruc, format: { with: /[0-9]+/, message: 'solo admite números' }
  validates :phone1, format: { with: /09([0-9]{8})+/, message: 'no es correcto ' }
  validates :ruc, uniqueness: true

  scope :recent, ->(number) { order(id: :desc).limit(number) }
end
