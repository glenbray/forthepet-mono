class SubscribeUser

  MAILCHIMP_API_KEY = 'f7f6773bc6abfb977a599b422c05e319-us4'

  attr_reader :message

  def initialize(email)
    @email = email
  end

  def subscribe
    gb = Gibbon::API.new(MAILCHIMP_API_KEY)

    begin
      gb.lists.subscribe(id: '7eb1a217a6', email: { email: @email }, double_optin: false)
      @message = 'Thanks for subscribing to For the Pet!'
      true
    rescue Gibbon::MailChimpError => e
      if (e.code != 200)
        @message = 'An unexpected error has occured! Please try again.'
        if e.code == 214
          @message = "The email #{@email} is already subscribed to our mailing lists."
        end
      end
      false
    end
  end

end
