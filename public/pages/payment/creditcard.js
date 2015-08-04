'use strict';

angular.module('thankubotapp')
	.controller('creditCardDialogController', ['$scope', 'stripe', '$modalInstance', 'Utils', function($scope, stripe, $modalInstance, Utils) {

		var init = function() {
			$scope.card = {
				number: '',
				exp_month: '12',
				exp_year: '2016',
				cvc: ''
			};
			$scope.error = '';
		};
		$scope.ok = function() {
			$scope.error = '';
			Utils.showWaiting('Processing...');
			stripe.card.createToken($scope.card)
				.then(function(token) {
					Utils.hideWaiting();
					$modalInstance.close(token.id);
				}).catch(function(err) {
					Utils.hideWaiting();
					$scope.error = err.message;
				});
		};

		$scope.cancel = function() {
			$modalInstance.dismiss('cancel');
		};

		init();
	}]);