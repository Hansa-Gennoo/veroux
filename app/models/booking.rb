class Booking < ApplicationRecord
  belongs_to :service

  enum status: { confirmed: 0, cancelled: 1 }

end
