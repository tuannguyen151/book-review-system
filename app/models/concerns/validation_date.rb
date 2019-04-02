module ValidationDate
  extend ActiveSupport::Concern

  class << self
    def min_date attribute, value
      date = Settings.years.years.ago
      return unless value <= date
      errors.add attribute, I18n.t("activerecord.min_date",
        date: date.strftime("%d/%m/%Y"))
    end

    def max_date attribute, value
      date = Settings.years.years.since

      return unless value >= date
      errors.add attribute, I18n.t("activerecord.max_date",
        date: date.strftime("%d/%m/%Y"))
    end
  end
end
