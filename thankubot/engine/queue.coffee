Request = require './request'
_ = require 'lodash'

class Queue
  constructor: ->
    @requests = {} # initialize all requests

  get: (user) ->
  	return if @requests[user.id]? then @requests[user.id] else null

  add: (request) ->
  	@requests[request.user.id] = request;

  remove: (request) ->
  	delete @.requests[request.user.id]
  	request

  update: (request) ->
  	@.requests[request.user.id] = request
  	request


module.exports = Queue