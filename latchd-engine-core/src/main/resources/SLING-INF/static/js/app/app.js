var LatchDApp = angular.module('LatchDApp',[
     'ngRoute',
     'imageControllers'
]);

LatchDApp.config(['$routeProvider',
     function($routeProvider) {
		$routeProvider.when('/images/:imageID',{
			templateUrl: '/static/js/app/partials/uploaded-images-list.html',
			controller: 'UploadedImagesController'
		}).otherwise({
			
		});
	 }
]);