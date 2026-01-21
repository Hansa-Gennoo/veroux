class User < ApplicationRecord
  before_validation :normalize_slug, :set_slug, on: :create

  VALID_SLUG = /\A[a-z0-9]+(?:-[a-z0-9]+)*\z/

  RESERVED_SLUGS = %w[
    admin support help pricing blog dashboard settings login signup
    veroux book bookings services profile
  ]

  validate :slug_not_reserved
  validate :slug_change_allowed, on: :update
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :services, dependent: :destroy
  has_many :bookings, through: :services, dependent: :destroy
  validates :slug,
  presence: true,
  uniqueness: true,
  length: { minimum: 3, maximum: 24 },
  format: { with: VALID_SLUG, message: "only lowercase letters, numbers, and single hyphens" }
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

  def normalize_slug
    return if slug.blank?
    self.slug = slug.to_s.downcase.strip
                    .gsub(/[^a-z0-9\s-]/, "")
                    .gsub(/\s+/, "-")
                    .gsub(/-+/, "-")
  end

  def slug_not_reserved
    return if slug.blank?
    errors.add(:slug, "is reserved") if RESERVED_SLUGS.include?(slug)
  end

  def slug_change_allowed
    return unless will_save_change_to_slug?
    if services.where(status: Service.statuses[:published]).exists?
      errors.add(:slug, "can’t be changed after you’ve published a service")
    end
  end
end
