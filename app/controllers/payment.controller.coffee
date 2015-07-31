# Module dependencies
db = require '../../config/sequelize'
config = require '../../config/config'
error = require './error.controller'

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
	res.render 'payment',
		request: req.request
		config: config

exports.pay = (req, res) ->
