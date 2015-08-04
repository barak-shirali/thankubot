'use strict';

angular.module('thankubotapp')
	.factory('Payment', ['$resource', function($resource) {
		return $resource('/payment/:slug', {
			slug: '@slug'
		}, {
			pay: {
				method: 'POST',
				url: '/payment/pay/:slug'
			}
		});
	}]);