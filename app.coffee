config = require './config/config'
bot = require './thankubot/bot'

console.log """
  initializing ThankuBot with #{process.env.NODE_ENV} environment...
"""
bot.start()