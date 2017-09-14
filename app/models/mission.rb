class Mission < ApplicationRecord
  has_many :mission_due_dates, dependent: :destroy
  has_many :mission_categories, dependent: :destroy
  has_many :mission_statuses, dependent: :destroy
  has_many :notifications, dependent: :destroy

  def status
    self.mission_statuses.order(:created_at).last
  end
end
