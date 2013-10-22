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

  class Customer
    attr_reader :response

    def intialize(options={})
      @response = options[:response]
    end

    def self.create(options={})
      response = Stripe::Customer.create(
        card: options[:card],
        email: options[:user].email,
        plan: "base"
        )
      new(response: response)
    end

    def successful?
      response.present?
    end
  end
end
