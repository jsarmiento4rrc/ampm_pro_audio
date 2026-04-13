# config/initializers/stripe.rb

# This file sets up the Stripe configuration for your application.
# Requirement 3.3.1: Integrate a 3rd party payment processor.

Rails.configuration.stripe = {
  :publishable_key => 'pk_test_51Oq9k9L9lG8W9X4Jp5v6x7y8z9a0b1c2d3e4f5g6h7i8j9k0l1m2n3o4p5q6r7s8t9u0v', # Replace with your actual PK
  :secret_key      => 'STRIPE_SECRET_KEY_HIDDEN' # Replace with your SK for local demo, but hide for Git push
}

# Apply the secret key to the Stripe Gem
Stripe.api_key = Rails.configuration.stripe[:secret_key]