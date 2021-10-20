# frozen_string_literal: true

# It manage users information, it works with Devise to define session and passwords.
class User < ApplicationRecord
  rolify

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable,
         :omniauthable, omniauth_providers: %i[facebook google_oauth2 twitter]

  has_many :vehicles, dependent: :destroy
  has_many :replacement_requests, dependent: :destroy
  has_many :shops, dependent: :destroy
  has_many :replacement_proposals, dependent: :destroy

  scope :recent, ->(number) { order(id: :desc).limit(number) }

  after_create :assign_default_role

  def assign_default_role
    add_role(:customer) if roles.blank?
  end

  def self.create_from_provider_data(provider_data)
    where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do |user|
      user.email = provider_data.info.email
      user.name = provider_data.info.name
      user.password = Devise.friendly_token[0, 20]
    end
  end
end
