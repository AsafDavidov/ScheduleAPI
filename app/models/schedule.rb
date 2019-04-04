class Schedule < ApplicationRecord
  # Decided to destroy all apointments associated with a schedule if it is destroy
  has_many :appointments, dependent: :destroy
end
