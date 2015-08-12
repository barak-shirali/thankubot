# Load config
env = process.env.NODE_ENV = process.env.NODE_ENV || 'local'
config = require './config/config'
db = require './config/sequelize'
_ = require 'lodash'
mailer = require './config/mailer'
json2csv = require 'json2csv'

db.Request.scope 'paid'
	.findAll
		order: [['createdAt', 'ASC']]
	.then (requests) ->
			json2csv
				data: requests
				fields: ['recipientName', 'recipientAddress', 'note', 'handwriting', 'senderName', 'senderAddress', 'createdAt']
				,
				(err, csv) ->
					if err isnt null
						console.log err
					else if requests.length > 0
						mailer.sendMail
							from: config.smtp.email
							to: config.smtp.email
							subject: 'You have new ' + requests.length + ' thank you requests'
							html: '<h2>Hi, Adam.</h2><h2>You have new ' + requests.length + ' thank you requests</h2>'
							attachments: [{filename: 'csv.csv',  'contentType': 'text/csv', 'content': csv}]
							,
							(err, success) ->
								if err isnt null
									console.log err
								else
									_.each requests, (request) ->
										request.status = 'COMPLETED'
										request.save()
		, (err) ->
			console.log err