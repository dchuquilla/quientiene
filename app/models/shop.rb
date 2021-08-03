class Shop < ApplicationRecord
  resourcify
  belongs_to :user
end
