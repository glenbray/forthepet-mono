class CalculatePostage

  def self.calculate(cart, postcode = nil)
    new(cart, postcode).calculate
  end

  def initialize(cart, postcode)
    @postcode = postcode.to_s.to_i
    @free_postage = cart.cart_items.map(&:variant).all?(&:free_postage)

    @weight = cart.cart_items
                  .reject { |item| item.variant.free_postage }
                  .reduce(0) { |a, item| a += item.variant.weight }
  end

  def calculate
    cost = 0
    unless free_postage?
      cost = 0 if @postcode.between?(2000, 2330) || # NSW
                  @postcode.between?(2600, 2617) || # ACT
                  @postcode.between?(4000, 4224) || # QLD
                  @postcode.between?(5000, 5200) || # SA
                  @postcode.between?(6000, 6206)    # WA

      if(@weight >= 4)
        cost = 35 if @postcode.between?(2331, 2999) # NSW & ACT
        cost = 40 if @postcode.between?(4225, 4449) # QLD
        cost = 60 if @postcode.between?(4450, 4999) # QLD
        cost = 60 if @postcode.between?(5201, 5999) # SA
        cost = 90 if @postcode.between?(6000, 6999) # WA
        cost = 80 if @postcode.between?(7000, 7999) # TAS
        cost = 90 if @postcode.between?(800, 999)   # NT
      else
        cost = 10 if @postcode.between?(2331, 2999) # NSW & ACT
        cost = 12 if @postcode.between?(4225, 4449) # QLD
        cost = 20 if @postcode.between?(4450, 4999) # QLD
        cost = 20 if @postcode.between?(5201, 5999) # SA
        cost = 25 if @postcode.between?(6207, 6999) # WA
        cost = 25 if @postcode.between?(7000, 7999) # TAS
        cost = 30 if @postcode.between?(800, 999)   # NT
      end
    end

    create_object(cost, @postcode)
  end

  private

  def create_object(cost, postcode)
    OpenStruct.new(
      cost: cost || 0,
      postcode: postcode.zero? ? "" : postcode
    )
  end

  def free_postage?
    !!@free_postage
  end
end
