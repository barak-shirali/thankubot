
payment = require './controllers/payment.controller'

module.exports = (app) ->
	console.log 'Initializing Routes...'

	# Payment Routes
	app.route '/payment/:slug'
		.get payment.view

	app.route '/payment/pay/:slug'
		.post payment.pay

	app.route '/success'
		.get payment.success

	app.param 'slug', payment.requestBySlug
