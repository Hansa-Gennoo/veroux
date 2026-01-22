class WeeklyAvailability < ApplicationRecord
  belongs_to :user
  validates :weekday, inclusion: { in: 0..6 }
end
