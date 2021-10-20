# frozen_string_literal: true

class IgnoredRequest < ApplicationRecord
  belongs_to :user
  belongs_to :replacement_request

  scope :mine, ->(user_id) { where(user_id: user_id) }
  scope :recent, ->(number) { order(id: :desc).limit(number) }
end
