module.exports =
  app:
    title: 'ThankUBot'
    url: 'https://thankubot.herokuapp.com'
  
  port: process.env.PORT || 80

  log:
    format: 'combined'
    options:
      stream: 'access.log'

  slack:
    token: 'xoxb-8351686320-bAA5NOTEvH8BYLbQubAaUxwh'

  db:
  	host: 'us-cdbr-iron-east-02.cleardb.net'
  	name: 'heroku_b9a64efb4b98d8f'
  	password: '7c0b7be7'
  	username: 'be54f6e130f360'

  smtp:
  	host: 'smtp.mandrillapp.com'
  	port: 587
  	username: 'barak.shirali@gmail.com'
  	password: 'ip0nalM5ROD7Y8uWPnLuWA'

  stripe:
  	secret_key: 'sk_test_GdfnQaDwJ0jwMwZkq11IugP5'
  	publishable_key: 'pk_test_vryarSLWowwIqr31dFjrQKtj'