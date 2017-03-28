module Shopping::CheckoutHelper
  def states
    [
      ['New South Wales', 'NSW'],
      ['Australian Capital Territory', 'ACT'],
      ['Northern Territory', 'NT'],
      %w(Queensland QLD),
      ['South Australia', 'SA'],
      %w(Tasmania TAS),
      %w(Victoria VIC),
      ['Western Australia', 'WA']
    ]
  end

  def expire_month
    [
      ['01 January', 1], ['02 Feburary', 2], ['03 March', 3], ['04 April', 4],
      ['05 May', 5], ['06 June', 6], ['07 July', 7], ['08 August', 8], ['09 September', 9],
      ['10 October', 10], ['11 November', 11], ['12 December', 12]
    ]
  end

  def credit_card_no
    development? ? 4_111_111_111_111_111 : ''
  end

  def cvv
    development? ? 111 : ''
  end

  def development?
    Rails.env.development?
  end
end
