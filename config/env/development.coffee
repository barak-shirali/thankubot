module.exports =
  app:
    title: 'ThankUBot'
    url: 'http://192.168.1.129:3000'
  
  port: process.env.PORT || 3000

  log:
    format: 'combined'
    options:
      stream: 'access.log'

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
    email: 'hof@assi.st'

  stripe:
    secret_key: 'sk_test_GdfnQaDwJ0jwMwZkq11IugP5'
    publishable_key: 'pk_test_vryarSLWowwIqr31dFjrQKtj'