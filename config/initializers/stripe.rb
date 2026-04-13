# config/initializers/stripe.rb

# This file sets up the Stripe configuration for your application.
# Requirement 3.3.1: Integrate a 3rd party payment processor.

Rails.configuration.stripe = {
  :publishable_key => 'pk_test_51THHZcCrPyiHw7vHJSAgsYC6C2pgPe1JgXKj5kq1SUaCQmxSEo5FXbmzXbFKkuJsv1LnNFzhwO5FX39GlVt2nSCe00rHfx515h', # Replace with your actual PK
  :secret_key      => 'sk_test_51THHZcCrPyiHw7vH3zXXD2gWiVV9wCzidmP2F9bKvBmiLrHzAysscOXOUtBUGLuZjVPcAoGvonzYOFhE01CADeDY00Cxm7ouM1' # Replace with your SK for local demo, but hide for Git push
}

# Apply the secret key to the Stripe Gem
Stripe.api_key = Rails.configuration.stripe[:secret_key]