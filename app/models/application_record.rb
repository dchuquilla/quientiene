# frozen_string_literal: true

# Parent class for all models you can define some globla methods
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
