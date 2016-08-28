class CalculatePostage

  def self.calculate(cart, postcode = nil)
    new(cart, postcode).calculate
  end

  def initialize(cart, postcode)
    @postcode = postcode.to_s.to_i

    @weight = cart.cart_items
                  .reduce(0) { |a, item| a += item.variant.weight }
  end

  def calculate
    cost = 0
    cost = 0 if @postcode.between?(2000, 2330) ||
                @postcode.between?(4000, 4224) ||
                @postcode.between?(5000, 5200) ||
                @postcode.between?(6000, 6206)

    if(@weight >= 4)
      cost = 35 if @postcode.between?(2331, 2999) # NSW
      cost = 40 if @postcode.between?(4225, 4449) # QLD
      cost = 60 if @postcode.between?(4450, 4999) # QLD
      cost = 60 if @postcode.between?(5201, 5999) # SA
      cost = 90 if @postcode.between?(6207, 6999) # WA
      cost = 80 if @postcode.between?(7000, 7999) # TAS
      cost = 90 if @postcode.between?(800, 999)   # NT
    else
      cost = 10 if @postcode.between?(2331, 2999) # NSW
      cost = 12 if @postcode.between?(4225, 4449) # QLD
      cost = 20 if @postcode.between?(4450, 4999) # QLD
      cost = 20 if @postcode.between?(5201, 5999) # SA
      cost = 25 if @postcode.between?(6207, 6999) # WA
      cost = 25 if @postcode.between?(7000, 7999) # TAS
      cost = 30 if @postcode.between?(800, 999)   # NT
    end

    OpenStruct.new(
      cost: cost || 0,
      postcode: @postcode.zero? ? "" : @postcode
    )
  end
end


# NSW
# Free freight 2000 to 2330
# $35 freight from 2331 to 2999 on dog food from 4kg up
# $10 freight from 2331 to 2999 on dog food below 3.99kg
# Free freight on all flea and tick varieties and worming products all over the state.

# ACT
# Free freight 2000 to 2330
# $35 freight from 2331 to 2999 on dog food from 4kg up
# $10 freight from 2331 to 2999 on dog food below 3.99kg
# Free freight on all flea and tick varieties and worming products all over the state.

# QLD
# Free freight 4000 to 4224
# $40 charge from 4225 to 4449 on dog food from 4kg up
# $12 freight from 4225 to 4449 on dog food below 3.99kg
# $60 charge from 4450 to 4999 on dog food from 4kg
# $20 charge from 4450 to 4999 on dog from below 3.99kg
# Free freight on all flea and tick varieties and worming products all over the state.

# SA
# Free Freight from 5000 to 5200
# $60 charge from 5201 to 5999 on dog food from 4kg up
# $20 charge from 5201 to 5999 on dog from below 3.99kg
# Free freight on all flea and tick varieties and worming products all over the state.

# WA
# Free freight from 6000 to 6206
# $90 from 6207 to 6999 on dog food from 4kg up
# $25 charge from 6207 to 6999 on dog from below 3.99kg
# Free freight on all flea and tick varieties and worming products all over the state.

# Tasmania
# No free freight on dog food, so please change this on the website.
# $80 from 7000 to 7999 on dog food from 4kg up
# $25 from 7000 to 7999 on dog food below 3.99kg
# Free freight on all flea and tick varieties and worming products all over the state.

# Northern Territory
# No free freight on dog food, so please change this on the website.
# $90 from 0800 to 0999 on dog food above 4kg
# $30 from 0800 to 0999 on dog food below 3.99kg
# Free freight on all flea and tick varieties and worming products all over the state.
