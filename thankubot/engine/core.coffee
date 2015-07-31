Parser = require './parser'
Request = require './request'
Response = require './response'
Queue = require './queue'
_ = require 'lodash'
q = require 'q'
addressValidator = require 'address-validator'

class CoreEngine
	constructor: (slack) ->
		@queue = new Queue
		@slack = slack
		Parser.setEngine @

	process: (msg, user, channel) ->

		deferred = q.defer()

		request = @queue.get user

		unless Parser.isfor msg, channel
			deferred.resolve null
			return deferred.promise

		msg = Parser.sanitize msg

		if request isnt null
			console.log 'Current request: ' + request.json()

		console.log """
		  Sanitized message : [#{msg}]
		"""

		success = (request) =>
			request.nextStep()
			@queue.update request
			deferred.resolve new Response request

		if Parser.isNewRequest msg
			if request is null
				request = @queue.add new Request user
			else
				request.setStep request.STEP0
			success request
		else if request is null
			deferred.resolve (new Response request).custom 'Please start with typing `send thx`'
		else if request.is request.STEP1
			if msg.length is 0
				deferred.resolve (new Response request).custom 'What is the first and last name of the person you want to thank?'
			else
				request.setRecipient msg
				success request
		else if request.is request.STEP2
			addressValidator.validate msg, addressValidator.match.streetAddress, (err, exact, inexact) ->
				if err or exact.length is 0
					deferred.resolve (new Response request).custom 'Hmmm. I didn’t get that. Can you try entering it again in the format `' + (if inexact.length > 0 then inexact[0] else '2123 Stuart St, Berkeley, CA 94705') + '`. Thank you.'
				else
					request.setRecipientAddress exact[0]
					success request
		else if request.is request.STEP3
			if msg.length is 0
				deferred.resolve (new Response request).custom 'What would you like your note to say?'
			else
				request.setNote msg
				success request
		else if request.is request.STEP4
			if Parser.isMale msg or Parser.isFemale msg
				request.setHandwriting Parser.gender msg
				success request
			else
				deferred.resolve (new Response request).custom 'Do you want this written in male or female handwriting?'
		else if request.is request.STEP5
			if Parser.isYes msg
				if user.name
					request.setSender user.name
					success request
				else
					deferred.resolve (new Response request).custom 'What is your name?'
			else
				request.setSender msg
				success request
		else if request.is request.STEP6
			addressValidator.validate msg, addressValidator.match.streetAddress, (err, exact, inexact) ->
				if err or exact.length is 0
					deferred.resolve (new Response request).custom 'Hmmm. I didn’t get that. Can you try entering it again in the format `' + (if inexact.length > 0 then inexact[0] else '2123 Stuart St, Berkeley, CA 94705') + '`. Thank you.'
				else
					request.setSenderAddress exact[0]
					request.complete ->
						queue.remove request
						deferred.resolve new Response request  	  	

		
		deferred.promise

module.exports = CoreEngine