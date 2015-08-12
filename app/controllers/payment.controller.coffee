# Module dependencies
db = require '../../config/sequelize'
config = require '../../config/config'
stripe = require '../lib/stripe'
error = require './error.controller'
moment = require 'moment'

exports.requestBySlug = (req, res, next, slug) ->
	db.Request.scope 'created'
		.find {where: {slug: slug}}
		.then (request) ->
			if request
				req.request = request
				next()
			else
				error.handle req, res, 404, 'Failed to load request [' + slug + ']'
		, (err) ->
			error.handle req, res, 404, err

exports.view = (req, res) ->
	db.ApplicationConfig
		.get 'PRICE', (price) ->
			res.render 'payment',
				request: req.request
				json: JSON.stringify req.request.json()
				config: config
				price: price

exports.pay = (req, res) ->
	token = req.body.token
	db.ApplicationConfig
		.get 'PRICE', (price) ->
			if price isnt null
				stripe.charges.create
					amount: parseInt(price) * 100
					currency: 'usd'
					source: token
					description: 'Payment for special thanks to ' + req.request.recipientName
					,
					(err, charge) ->
						if err is null
							req.request.stripeToken = charge.id
							req.request.status = 'PAID'
							req.request.paidAt = moment().format()
							req.request.save()

							res.send
								success: true
						else
							res.send
								success: false
								message: err
			else
				console.log """
					Can not load Application Config value for PRICE
				"""
				res.send
					success: false
					message: ''

exports.success = (req, res) ->
	res.render 'success',
		config: config