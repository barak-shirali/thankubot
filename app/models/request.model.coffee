md5 = require 'md5'

module.exports = (sequelize, DataTypes) ->
	Request = sequelize.define 'Request', {
			slack_user_id: DataTypes.STRING
			recipientName: DataTypes.STRING
			recipientAddress: DataTypes.STRING
			note: DataTypes.STRING
			handwriting: DataTypes.ENUM 'male', 'female'
			senderName: DataTypes.STRING
			senderAddress: DataTypes.STRING
			slug: DataTypes.STRING
			status: DataTypes.ENUM 'CREATED', 'FAILED', 'EXPIRED', 'PAID', 'COMPLETED', 'DELETED'
			paidAt: DataTypes.DATE
			stripeToken: DataTypes.STRING
		}, {
			scope:
				deleted: { where: { status: 'DELETED' }}
				not_deleted: { where: { status: { ne: 'DELETED' }}}
				created: { where: { status: 'CREATED' }}
				failed: { where: { status: 'FAILED' }}
				expired: { where: { status: 'EXPIRED' }}
				paid: { where: { status: 'PAID' }}
				completed: { where: { status: 'COMPLETED' }}
				any: (status) ->
					{ where: { status: status }}
			,
			classMethods:
				generateSlug: (instance, next) ->
					slug = md5 Date.now()
					Request.count
						where:
							slug: slug
					.then (count) ->
						if count isnt 0
							Request.generateSlug instance, next
						else
							next slug
			,
			hooks:
				beforeCreate: (instance, options, fn) ->
					Request.generateSlug instance, (slug) ->
						instance.slug = slug;
						fn null, instance
			
		}

	Request
