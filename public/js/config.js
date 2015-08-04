'use strict';

angular.module('thankubotapp')
	.config(['$routeProvider', function($routeProvider) {
		$routeProvider
			.otherwise({
				redirectTo: '/'
			});
	}])

	.config(['$controllerProvider', function($controllerProvider) {
		$controllerProvider.allowGlobals();
	}])

	.config(['$locationProvider', function($locationProvider) {
		$locationProvider.hashPrefix('!');
	}])

	.config(['stripeProvider', function(stripeProvider) {
		stripeProvider.setPublishableKey(STRIPE_PUBLISHABLE_KEY);
	}]);