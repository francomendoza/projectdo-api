class MissionCategory < ApplicationRecord
  belongs_to :mission
  belongs_to :category
end
