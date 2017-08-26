class Mission < ApplicationRecord
  has_many :mission_due_dates
  has_many :mission_categories
end
