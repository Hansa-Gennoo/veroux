class Booking < ApplicationRecord
  belongs_to :service

  enum status: { confirmed: 0, cancelled: 1 }

  validates :client_name, :client_email, :starts_at, presence: true
  validates :client_email, format: { with: URI::MailTo::EMAIL_REGEXP }

end
