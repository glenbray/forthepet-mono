module CartItemsHelper

  def full_delivery_frequency_options include_once = true
    options = []
    options << ['Deliver Once', nil] if include_once
    options + [
      ['Delivery Every 1 Week', 'one_week'],
      ['Delivery Every 2 Weeks', 'two_weeks'],
      ['Delivery Every 3 Weeks', 'three_weeks'],
      ['Delivery Every 4 Weeks', 'four_weeks'],
      ['Delivery Every 5 Weeks', 'five_weeks'],
      ['Delivery Every 6 Weeks', 'six_weeks'],
      ['Delivery Every 7 Weeks', 'seven_weeks'],
      ['Delivery Every 8 Weeks', 'eight_weeks'],
      ['Delivery Every 3 Months', 'three_months'],
      ['Delivery Every 6 Months', 'six_months']
    ]
  end

  def short_delivery_frequency_options
    [
      ['1 Week', 'one_week'],
      ['2 Weeks', 'two_weeks'],
      ['3 Weeks', 'three_weeks'],
      ['4 Weeks', 'four_weeks'],
      ['5 Weeks', 'five_weeks'],
      ['6 Weeks', 'six_weeks'],
      ['7 Weeks', 'seven_weeks'],
      ['8 Weeks', 'eight_weeks'],
      ['3 Months', 'three_months'],
      ['6 Months', 'six_months']
    ]
  end

  def frequency_to_text frequency
    case frequency.to_sym
    when :one_week
      'Every 1 Week'
    when :two_weeks
      'Every 2 Weeks'
    when :three_weeks
      'Every 3 Weeks'
    when :four_weeks
      'Every 4 Weeks'
    when :five_weeks
      'Every 5 Weeks'
    when :six_weeks
      'Every 6 Weeks'
    when :seven_weeks
      'Every 7 Weeks'
    when :eight_weeks
      'Every 8 Weeks'
    when :three_months
      'Every 3 Months'
    when :six_months
      'Every 6 Months'
    else
      nil
    end
  end
end

