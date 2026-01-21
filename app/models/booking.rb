class Booking < ApplicationRecord
  belongs_to :service

  enum :status, { confirmed: 0, cancelled: 1 }

  enum :payment_status, { unpaid: 0, paid: 1, refunded: 2 }

  validates :client_name, :client_email, :starts_at, presence: true
  validates :client_email, format: { with: URI::MailTo::EMAIL_REGEXP }

end
