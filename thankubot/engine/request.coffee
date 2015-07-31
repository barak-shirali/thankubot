q = require 'q'
sequelize = require '../../config/sequelize'

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
    sequelize.Request.create @.db()
      .then (dbRequest) =>
        # set data
        @.setId dbRequest.slug
        @.setStep @.STEP7

        deferred.resolve @
      , (err) =>
        console.log """
          ***Database error : #{err}
        """
        deferred.reject @

    deferred.promise

  db: ->
    db =
      slack_user_id: @user.id
      recipientName: @recipient
      recipientAddress: @recipientAddress.toString()
      note: @note
      handwriting: @handwriting
      senderName: @sender
      senderAddress: @senderAddress.toString()
      status: 'CREATED'

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