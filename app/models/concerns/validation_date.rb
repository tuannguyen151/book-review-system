module ValidationDate
  extend ActiveSupport::Concern

  class << self
    def min_date object, attribute, value
      date = Settings.years.years.ago
      return unless value && value <= date
      object.errors.add attribute, I18n.t("activerecord.min_date",
        date: date.strftime("%d/%m/%Y"))
    end

    def max_date object, attribute, value
      date = Settings.years.years.since

      return unless value && value >= date
      object.errors.add attribute, I18n.t("activerecord.max_date",
        date: date.strftime("%d/%m/%Y"))
    end
  end
end
