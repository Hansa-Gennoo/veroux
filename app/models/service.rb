class Service < ApplicationRecord
  belongs_to :user

  attribute :status, :integer

  enum :goal, { discovery: 0, paid: 1, qualify: 2 }
  enum :status, { draft: 0, published: 1, archived: 2 }

  has_many :bookings, dependent: :destroy

  validates :title, presence: true
  validates :duration_minutes, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true
  validates :price_cents, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true

end
