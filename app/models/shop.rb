class Shop < ApplicationRecord
  resourcify
  belongs_to :user

  validates :name, :address, :ruc, :phone1, presence: true
  validates :ruc, format: { with: /\A[0-9]+\z/, message: "solo admite números" }
  validates :phone1, format: { with: /\A[0-9]+\z/, message: "solo admite números" }
end
