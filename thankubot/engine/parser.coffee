
Parser =
  setEngine: (engine) ->
  	@engine = engine

  escapeRegExp: (regexp) ->
    regexp.replace(/([.*+?^=!:${}()|\[\]\/\\])/g, "\\$1");

  sanitize: (msg) ->

  	# remove slack user id
  	filter = Parser.escapeRegExp '<@' + @engine.slack.self.id + '>:'
  	regexBot = new RegExp filter, 'g'
  	msg = msg.replace regexBot, ''

  	# trim
  	msg.trim()

  isNewRequest: (msg) ->
  	cmd = new String msg
  	cmd = Parser.sanitize cmd.toLowerCase()

  	if cmd is 'send thx'
  	  true
    else
      false

  isMale: (msg) ->
  	cmd = Parser.gender msg

  	if cmd is 'male'
  	  true
    else
      false

  isFemale: (msg) ->
  	cmd = Parser.gender msg

  	if cmd is 'female'
  	  true
    else
      false

  gender: (msg) ->
  	cmd = new String msg
  	cmd = Parser.sanitize cmd.toLowerCase()

  	if cmd is 'male'
  	  'male'
  	else if cmd is 'female'
  	  'female'
  	else
  	  ''

  isYes: (msg) ->
  	cmd = new String msg
  	cmd = Parser.sanitize cmd.toLowerCase()

  	if cmd is 'yes' or cmd is 'yeah' or cmd is 'yup'
  	  true
  	else
  	  false

  isNo: (msg) ->
  	cmd = new String msg
  	cmd = Parser.sanitize cmd.toLowerCase()

  	if cmd is 'no' or cmd is 'nah' or cmd is 'nope'
  	  true
  	else
  	  false


module.exports = Parser