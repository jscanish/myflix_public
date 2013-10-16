require 'spec_helper'

describe StripeWrapper do
  describe StripeWrapper::Charge do
    describe ".create" do
      it "successfully charges credit card", :vcr do
        Stripe.api_key = ENV['STRIPE_SECRET_KEY']
        token = Stripe::Token.create(
          :card => {
            :number => "4242424242424242",
            :exp_month => 6,
            :exp_year => 2018,
            :cvc => "314"
          }
        ).id

        response = StripeWrapper::Charge.create(
          amount: 999,
          card: token,
          description: "A valid charge",
        )
        expect(response).to be_successful
      end

      it "does not charge invalid card", :vcr do
        Stripe.api_key = ENV['STRIPE_SECRET_KEY']
        token = Stripe::Token.create(
          :card => {
            :number => "4000000000000002",
            :exp_month => 6,
            :exp_year => 2018,
            :cvc => "314"
          }
        ).id

        response = StripeWrapper::Charge.create(
          amount: 999,
          card: token,
          description: "An invalid charge",
        )
        expect(response).to_not be_successful
      end

      it "returns error message for declined charges", :vcr do
        Stripe.api_key = ENV['STRIPE_SECRET_KEY']
        token = Stripe::Token.create(
          :card => {
            :number => "4000000000000002",
            :exp_month => 6,
            :exp_year => 2018,
            :cvc => "314"
          }
        ).id

        response = StripeWrapper::Charge.create(
          amount: 999,
          card: token,
          description: "An invalid charge",
        )
        expect(response.error_message).to eq("Your card was declined.")
      end
    end
  end
end
