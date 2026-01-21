class User < ApplicationRecord
  before_validation :set_slug, on: :create
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :services, dependent: :destroy
  has_many :bookings, through: :services, dependent: :destroy
  validates :slug, presence: true, uniqueness: true
  validates :display_name, presence: true, allow_blank: false

  private

  def set_slug
    return if slug.present?

    base = email.to_s.split("@").first.to_s.parameterize
    base = "user" if base.blank?

    candidate = base
    n = 2

    while User.exists?(slug: candidate)
      candidate = "#{base}-#{n}"
      n += 1
    end

    self.slug = candidate
  end
end
