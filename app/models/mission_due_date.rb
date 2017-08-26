class MissionDueDate < ApplicationRecord
  belongs_to :mission
  validates :mission_id, presence: true
  validates :option, presence: true
end
