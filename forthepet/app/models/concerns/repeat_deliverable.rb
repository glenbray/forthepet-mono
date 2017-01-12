module RepeatDeliverable
  extend ActiveSupport::Concern

  included do
    enum frequency: {
      one_week:     1,
      two_weeks:    2,
      three_weeks:  3,
      four_weeks:   4,
      five_weeks:   5,
      six_weeks:    6,
      seven_weeks:  7,
      eight_weeks:  8,
      three_months: 9,
      six_months:   10
    }
  end

  def frequency_to_time
    case frequency.to_sym
    when :one_week
      1.week
    when :two_weeks
      2.weeks
    when :three_weeks
      3.weeks
    when :four_weeks
      4.weeks
    when :five_weeks
      5.weeks
    when :six_weeks
      6.weeks
    when :seven_weeks
      7.weeks
    when :eight_weeks
      8.weeks
    when :three_months
      3.months
    when :six_months
      6.months
    else
      nil
    end
  end
end
