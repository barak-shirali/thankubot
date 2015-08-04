'use strict';

angular.module('thankubotapp')
	.controller('paymentController', ['$scope', 'Payment', 'GENDER', '$modal', 'Utils', function($scope, Payment, GENDER, $modal, Utils) {

		var init = function() {
			$scope.request = new Payment(request);

			$scope.GENDER = GENDER;

			$scope.error = '';
		};

		$scope.process = function(token) {
			Utils.showWaiting('Processing...');
			$scope.error = '';
			$scope.request.token = token;
			$scope.request.$pay()
				.then(function(result) {
					Utils.hideWaiting();
					window.location = '/success';
				}, function(err) {
					Utils.hideWaiting();
					$scope.error = 'Failed to complete the payment. Please try again.';
				});
		};

		$scope.onPay = function() {
			var modalInstance = $modal.open({
				animation: true,
				templateUrl: '../pages/payment/creditcard.html',
				controller: 'creditCardDialogController',
				size: 'sm',
				resolve: {
	        
				}
			});

			modalInstance.result.then(function (token) {
				$scope.process (token);
			}, function () {
	    
			});
		};

		init();
	}]);