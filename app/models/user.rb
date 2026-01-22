class User < ApplicationRecord
  before_validation :normalize_slug, :set_slug, on: :create
  after_create :ensure_weekly_availability

  VALID_SLUG = /\A[a-z0-9]+(?:-[a-z0-9]+)*\z/

  RESERVED_SLUGS = %w[
    admin support help pricing blog dashboard settings login signup
    veroux book bookings services profile
  ]

  validate :slug_not_reserved
  validate :slug_change_allowed, on: :update

  enum :plan, { starter: 0, growth: 1, agency: 2 }, prefix: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :services, dependent: :destroy
  has_many :bookings, through: :services, dependent: :destroy
  has_many :weekly_availabilities, dependent: :destroy

  validates :slug,
  presence: true,
  uniqueness: true,
  length: { minimum: 3, maximum: 24 },
  format: { with: VALID_SLUG, message: "only lowercase letters, numbers, and single hyphens" }
  validates :display_name, presence: true, allow_blank: false, if: :has_published_services?

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


  def has_published_service?
    services.published.exists?
  end

  def ensure_weekly_availability
    (0..6).each do |weekday|
      WeeklyAvailability.find_or_create_by!(user: self, weekday: weekday) do |wa|
        wa.enabled = (1..5).include?(weekday) # default Mon-Fri on
        wa.start_time = 540 # "09:00"
        wa.end_time = 1020 # "17:00"
      end
    end
  end
end
