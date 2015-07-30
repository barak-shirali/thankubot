q = require 'q'

class Request
  constructor: (user) ->
    @user = user
    @step = @.STEP0
  
  setStep: (step) ->
    @step = step

  setRecipient: (recipient) ->
    @recipient = recipient
  
  setRecipientAddress: (address) ->
    @recipientAddress = address

  setNote: (note) ->
    @note = note.substr 0, 50

  setHandwriting: (handwriting) ->
    @handwriting = handwriting

  setSender: (sender) ->
    @sender = sender

  setSenderAddress: (address) ->
    @senderAddress = address

  setId: (id) ->
    @id = id

  is: (step) ->
    if @step == step
      true
    else
      false

  nextStep: ->
    @step = @step + 1
    if @step > @.STEP7
      @step = @.STEP7
    @step

  complete: ->
    deferred = q.defer()

    # add to database
    @.setId 'dummyurl'

    deferred.resolve(@)
    deferred.promise

  json: ->
    json = 
      userId: @user.id
      step: @step
      recipient: @recipient
      recipientAddress: @recipientAddress
      note: @note
      handwriting: @handwriting
      sender: @sender
      senderAddress: @senderAddress
      id: @id
    JSON.stringify json

  # Step constants
  STEP0: 0
  STEP1: 1
  STEP2: 2
  STEP3: 3
  STEP4: 4
  STEP5: 5
  STEP6: 6
  STEP7: 7


module.exports = Request