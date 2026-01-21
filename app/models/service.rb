class Service < ApplicationRecord
  belongs_to :user

  enum goal: { discovery: 0, paid: 1, qualify: 2 }

  has_many :bookings, dependent: :destroy

end
