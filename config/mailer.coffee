mailer = require 'nodemailer'
config = require './config'
smtpTransport = require 'nodemailer-smtp-transport'
transport = mailer.createTransport smtpTransport
	host: config.smtp.host
	port: config.smtp.port
	auth:
		user: config.smtp.username
		pass: config.smtp.password

module.exports = transport