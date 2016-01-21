module DealsHelper

  def variants_select
    return if @product.variants.empty?

    variant_options = @product.variants.map do |v|
      options = v.to_s
      price = @deal.deal_prices.find_by_variant_id(v.id).price
      options = "#{options} - #{number_to_currency(price)}"

      [options, v.id]
    end
  end

  def twitter_share_url
    encoded_url = encoded_url(generate_referral)
    twitter_text_encoded = CGI.escape('Check out this bargain. Getting myself one of these!')
    "//twitter.com/intent/tweet?text=#{twitter_text_encoded}+#{encoded_url}"
  end

  def facebook_share_url
    encoded_url = encoded_url(generate_referral)
    "//www.facebook.com/sharer/sharer.php?u=#{encoded_url}"
  end

  private

  def generate_referral
    referral = ''
    if current_user && current_user.referral_id.nil?
      current_user.referral_id = Digest::MD5.hexdigest(current_user.email)
      current_user.save
    end

    if current_user
      referral = "?rid=#{current_user.referral_id}"
    end

    referral
  end

  def encoded_url(referral)
    CGI.escape(request.original_url + referral)
  end

end
