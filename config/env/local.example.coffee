module.exports =
  app:
    title: 'ThankUBot'
  
  port: process.env.PORT || 3007

  slack:
    token: 'xoxb-8351686320-bAA5NOTEvH8BYLbQubAaUxwh'

  db:
  	host: '192.168.1.129'
  	name: 'thankubot_db'
  	password: ''
  	username: 'root'

  smtp:
  	host: '192.168.1.128'
  	port: 25
  	username: ''
  	password: ''

  stripe:
  	secret_key: ''
  	publishable_key: ''