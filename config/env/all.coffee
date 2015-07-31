path = require 'path'
rootPath = path.normalize __dirname + '/../..'

module.exports =
  app:
    title: 'ThankUBot'
  rootPath: rootPath
  modelsDir: rootPath + '/app/models'
  
  port: process.env.PORT || 3000