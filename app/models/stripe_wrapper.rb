module StripeWrapper
  class Charge
    def initialize(response, error_message)
      @response = response
      @error_message = error_message
    end

    def self.create(options={})
      begin
        response = Stripe::Charge.create(
          amount: options[:amount],
          currency: "usd",
          card: options[:card],
          description: options[:description]
        )
        new(response, nil)
      rescue Stripe::CardError => e
        new(nil, e.message)
      end
    end

    def successful?
      @response.present?
    end

    def error_message
      @error_message
    end
  end
end
