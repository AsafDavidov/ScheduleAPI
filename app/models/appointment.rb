class Appointment < ApplicationRecord
  belongs_to :schedule
  validates_numericality_of :start_time
  validates_numericality_of :end_time, :greater_than => :start_time
end
