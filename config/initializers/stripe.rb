Rails.configuration.stripe = {
  publishable_key: 'pk_test_51THHZcCrPyiHw7vHJSAgsYC6C2pgPe1JgXKj5kq1SUaCQmxSEo5FXbmzXbFKkuJsv1LnNFzhwO5FX39GlVt2nSCe00rHfx515h',
  secret_key:      'sk_test_51THHZcCrPyiHw7vH3zXXD2gWiVV9wCzidmP2F9bKvBmiLRhzAyssc0XO0UtBUGluZjVPcAoGvonzY0FhE01CADeDY00Cxm7ouM1'
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]