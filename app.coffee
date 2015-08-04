# Load config
env = process.env.NODE_ENV = process.env.NODE_ENV || 'local'
config = require './config/config'
db = require './config/sequelize'
bot = require './thankubot/bot'

# Start bot
bot.start()

# Initialize express
app = (require './config/express') db

# Start the app by listening on <port>
port = process.env.PORT || config.port
app.listen port

console.log """
	Express app started on port #{port}
"""

# Expose app
exports = module.exports = app
