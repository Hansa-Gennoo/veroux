module ServicesHelper
  def service_price(service)
    return "Free" if service.price_cents.to_i.zero?

    number_to_currency(service.price_cents / 100.0, unit: service.currency || "$")
  end
end
