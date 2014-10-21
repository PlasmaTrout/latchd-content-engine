var imageControllers = angular.module('imageControllers',[]);

imageControllers.controller('UploadedImagesController',['$scope','$http','$routeParams',
    function($scope,$http,$routeParams) {
	$http.get('/uploads/images.tidy.infinity.json').success(function(data){
		$scope.uploads = [];
		for(p in data){
			if(p.indexOf("jcr:") == -1){
				$scope.uploads.push({
					path: "/uploads/images/"+p,
					savePath: Sling.currentPath+"/"+$routeParams.imageID
				});
			}
		}
	});
}]);


