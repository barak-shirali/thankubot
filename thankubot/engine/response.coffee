config = require '../../config/config'

class Response
  constructor: (request) ->
    @.setRequest request

  setMessage: (message) ->
    @message = message

  setRequest: (request) ->
    @request = request
    if request isnt null
      if request.is request.STEP1
        @.setMessage 'But of course' + (if request.user?.name? then ', ' + request.user.name else '') + '. What is the first and last name of the person you want to thank?'
      else if request.is request.STEP2
        @.setMessage 'Oh! ' + request.recipient + ' sure is lucky. What is ' + request.recipient + '\'s address? (ex: 2123 Stuart St, Berkeley, CA 94705)'
      else if request.is request.STEP3
        @.setMessage 'Ok, what would you like your note to say? You can use up to 50 characters.'
      else if request.is request.STEP4
        @.setMessage 'Aw, they’re so lucky. Do you want this written in `male` or `female` handwriting?'
      else if request.is request.STEP5
        @.setMessage 'Is the note from you? If it is, say `yes` if not, please tell me who the note is from.'
      else if request.is request.STEP6
        @.setMessage 'What should I list for the return address?'
      else if request.is request.STEP7
        @.setMessage 'Excellent! Just to confirm, I am sending a handwritten note from `' + request.sender + '` to `' + request.recipient + '` located at `' + request.recipientAddress + '`. The note will read `' + request.note + '`. Click this link to confirm and pay ' + config.app.url + '/payment/' + request.id + ''

  custom: (message) ->
    @.setMessage message
    @


module.exports = Response