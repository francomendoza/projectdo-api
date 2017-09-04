class Mission < ApplicationRecord
  has_many :mission_due_dates, dependent: :destroy
  has_many :mission_categories, dependent: :destroy
  has_many :mission_statuses, dependent: :destroy
end
