module.exports =
  app:
    title: 'ThankUBot'
  
  port: process.env.PORT || 80

  slack:
    token: 'xoxb-8351686320-bAA5NOTEvH8BYLbQubAaUxwh'

  db:
  	host: '192.168.1.129'
  	name: 'thankubot_db'
  	password: ''
  	username: 'root'

  smtp:
  	host: 'smtp.mandrillapp.com'
  	port: 587
  	username: 'barak.shirali@gmail.com'
  	password: 'ip0nalM5ROD7Y8uWPnLuWA'

  stripe:
  	secret_key: ''
  	publishable_key: ''