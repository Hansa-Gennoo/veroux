class SlotGenerator
  # Generates discrete bookable slots for a given service
  # for a given date range (e.g. next 14 days)
  def initialize(service:, from_date:, to_date:)
    @service = service
    @provider = service.user
    @from_date = from_date
    @to_date = to_date
  end

  def call
    slots = []
    (@from_date..@to_date).each do |date|
      weekday = date.wday # 0=Sunday..6=Saturday
      wa = WeeklyAvailability.find_by(user: @provider, weekday: weekday)
      next unless wa&.enabled?

      day_slots = slots_for_day(date, wa)
      slots.concat(day_slots)
    end

    remove_conflicts(slots)
  end

  private

  def slots_for_day(date, wa)
    duration = @service.duration_minutes.to_i
    return [] if duration <= 0

    start_dt = Time.zone.parse("#{date} #{wa.start_time}")
    end_dt   = Time.zone.parse("#{date} #{wa.end_time}")
    return [] if start_dt.nil? || end_dt.nil? || end_dt <= start_dt

    slots = []
    cursor = start_dt

    while cursor + duration.minutes <= end_dt
      slots << cursor
      cursor += duration.minutes
    end

    slots
  end

  def remove_conflicts(slots)
    booked = Booking.joins(:service)
                    .where(services: { user_id: @provider.id })
                    .where(starts_at: slots.min..slots.max)
                    .pluck(:starts_at)
                    .to_set

    slots.reject { |t| booked.include?(t) }
  end
end
