module CartItemsHelper

  def full_delivery_frequency_options
    [
      ['Deliver Once', nil],
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
end

