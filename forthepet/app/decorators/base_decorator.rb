class BaseDecorator < Draper::Decorator
  delegate_all

  DATE_FORMAT = '%d-%m-%Y'
  DATE_TIME_FORMAT = '%d-%m-%Y %H:%M'

  def self.collection_decorator_class
    PaginatingDecorator
  end

  def format_currency(number)
    h.number_to_currency(number.to_f.round(2))
  end

  def format_date(date)
    date = date.try(:to_date)
    date.strftime(DATE_FORMAT) if date
  end

  def format_date_time(date)
    date.strftime(DATE_TIME_FORMAT) rescue date
  end

  def two_decimals(number)
    sprintf('%.2f', number)
  end
end
