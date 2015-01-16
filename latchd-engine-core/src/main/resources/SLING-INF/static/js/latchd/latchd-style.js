var LatchD = {};

LatchD.style = function(){
	
	var styles = [];
	styles.push({ main: "tk-minion-pro", title: "tk-open-sans"});
	styles.push({ main: "tk-chaparral-pro", title: "tk-futura-pt"});
	styles.push({ main: "tk-adobe-garamond-pro", title: "tk-eurpopa"});
	
	var currentStyle = 0;
    var currentIndent = 0;

	var clearFonts = function(){
		$(styles).each(function(x,item){
			$("p[id]").removeClass(item.main);
			$(":header[id]").removeClass(item.title);
			$("p[rel=quote]").removeClass(item.title);
			$("div[rel=image]").removeClass(item.title);
		});
	};

	var changeIndent = function(value){
		var ps = $("p[id]");
		var capped = $("p[id]").first().children().length === 1;
		if(capped){
			ps = $("p[id]").slice(1);
		}
		$("#indentspan").html("Indent Size "+value+"px");
		ps.attr("style","text-indent: "+value+"px");
        currentIndent = value;
	};

    var increaseIndent = function(increment,currentValue){
        var newVal = currentIndent+increment;
        if(currentValue){
            newVal = newVal+currentValue;
        }
        changeIndent(newVal);
        return newVal;
    };

    var decreaseIndent = function(increment,currentValue){
        var newVal = currentIndent-increment;
        if(currentValue){
            newVal = newVal-increment;
        }
        if(newVal <= 0){
            newVal = 0;
        }
        changeIndent(newVal);
        return newVal;
    };
	
	var saveIndent = function(path,value){
		$.ajax({
			type: "POST",
			url: path,
			data: { indent: value }
		}).done(function(){
			 console.log("new indent saved!");
		}).fail(function(error){
			console.log("Error: "+error);
		});
	}
	
	
	
	var dropCapOn = function(){
		var first = $("p[id]").first();
		first.addClass("noindent");
		first.removeClass("indent");
		
		var firstChar = first.html()[0];
		
		var cap = document.createElement("span");
		cap.setAttribute("class","dropcap");
		cap.innerHTML = firstChar;
		
		var rest = first.html().substring(1);
		first.html(cap.outerHTML+rest);
	}
	
	var dropCapOff = function(){
		var first = $("p[id]").first();
		first.addClass("indent");
		first.removeClass("noindent");
		
		first.html(first[0].innerText);
	}
	
	var dropCap = function() {
		var notCapped = $("p[id]").first().children().length === 0;
		
		if(notCapped){
			dropCapOn();
		}else{
			dropCapOff();
		}
		
	}
	
	
	var setMainFont = function(value){
		$("p[id]").addClass(value);
	};
	
	var setTitleFont = function(value){
		$(":header[id]").addClass(value);
		$("p[rel=quote]").addClass(value);
		$("div[rel=image]").addClass(value);
	};
	
	var setTypography = function(value){
		var style = styles[value];
		if(style){
			currentStyle = value;
			clearFonts();
			setMainFont(style.main);
			setTitleFont(style.title);
		}
	};
	
	var refreshTypography = function(){
		setTypography(currentStyle);
	};
	
	var justify = function(value){
		var ps = $("p[id]");
		if(value){
			ps.addClass("justified");
		}else{
			ps.removeClass("justified");
		}
	};
	
	
	
	
	return {
		dropcap: dropCap,
        indent: changeIndent,
        decreaseIndent: decreaseIndent,
        increaseIndent: increaseIndent,
		setTypography: setTypography,
		justify: justify,
		refreshTypography: refreshTypography
	};
}();
