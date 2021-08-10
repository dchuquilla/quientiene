class ReplacementProposal < ApplicationRecord
  belongs_to :user
  belongs_to :shop
  belongs_to :replacement_request
end
