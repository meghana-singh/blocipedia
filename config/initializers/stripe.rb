# Store the environment variables on the Rails.configuration object
 Rails.configuration.stripe = {
   #publishable_key: ENV['STRIPE_PUBLISHABLE_KEY'],
   publishable_key: 'pk_test_8VnlZ13U64jgylxVue7ZaAUG',
   #secret_key: ENV['STRIPE_SECRET_KEY']
   secret_key: 'sk_test_GW5oHN46PwHPjVZ2CrAeezEC'
 }
 
 # Set our app-stored secret key with Stripe
 Stripe.api_key = Rails.configuration.stripe[:secret_key]