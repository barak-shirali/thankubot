md5 = require 'md5'

module.exports = (sequelize, DataTypes) ->
	ApplicationConfig = sequelize.define 'ApplicationConfig', {
			key: DataTypes.STRING
			value: DataTypes.TEXT
		}, {
			classMethods:
				get: (key, next) ->
					ApplicationConfig
						.find {where: {key: key}}
						.then (config) ->
							if config
								next config.value
							else
								next null
						, (err) ->
							console.log err
							next null
				,
				set: (key, value, next) ->
					ApplicationConfig
						.find {where:{key: key}}
						.then (config) ->
							if config
								config.value = value
								config
									.save()
									.then (config) ->
										next config
									, (err) ->
										console.log err
										next null
							else
								next null
						, (err) ->
							console.log err
							next null
			
		}

	ApplicationConfig
