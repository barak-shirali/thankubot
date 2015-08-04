config = require '../../config/config'
stripe = (require 'stripe') config.stripe.secret_key

module.exports = stripe