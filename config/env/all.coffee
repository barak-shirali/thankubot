path = require 'path'
rootPath = path.normalize __dirname + '/../..'

module.exports =
  app:
    title: 'ThankUBot'
  
  port: process.env.PORT || 3000