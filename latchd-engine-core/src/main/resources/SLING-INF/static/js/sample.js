// In this case, the snippet file block was used with a
// file pointer instead of a snippet code block.
var Sample = function() {
	
	var privateVar = "Hello World!";
	
	var innerFunction = function(){
		console.log(privateVar);
	};
	
	return {
		inner: innerFunction
	};
	
}();