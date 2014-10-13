
var LatchD = function(){
	
	var styles = [];
	styles.push({ main: "georgia", title: "header-verdana"});
	styles.push({ main: "libre-baskerville", title: "header-source-sans"});
	styles.push({ main: "garamond", title: "header-helvetica"});
	styles.push({ main: "baskerville", title: "header-franklin"});
	styles.push({ main: "garamond", title: "header-gills"});
	
	var clearSelections = function(){
		var paras = $("p[id],blockquote");
		paras.each(function(ix,item){
			$(item).removeClass("paraselect");
		});
	};
	
	var clearFonts = function(){
		$(styles).each(function(x,item){
			$("p[id]").removeClass(item.main);
			$(":header[id]").removeClass(item.title);
			$("p[rel=quote]").removeClass(item.title);
			$("div[rel=image]").removeClass(item.title);
		});
	};
	
	var highlightSelection = function(item){
		clearSelections();
		$(item).addClass("paraselect");
		localStorage.setItem(item.id,item.innerText);
	};
	
	var findSelectedPara = function(path){
		var paras = $("p[id]");
		paras.each(function(ix,item){
			if(item.id === path){
				$(item).addClass("paraselect");
			}else{
				$(item).removeClass("paraselect");
			}
		});
	};
	
	var paragraphChanged = function(item){
		console.log(item.innerText);
		if(localStorage.getItem(item.id) === item.innerText){
			console.log("No changes noticed!");
		}else{
			console.log(item.id+" was changed, we need to save it!");
			$.ajax({
				type: "POST",
				url: item.id,
				data: { value: item.innerText }
			}).done(function(){
				 console.log("successfull save!");
			}).fail(function(error){
				console.log("Error: "+error);
			});
		}
	};
	
	var saveNewParagraph = function(item){
		$.ajax({
			type: "POST",
			url: item.id,
			data: { value: item.innerText, "sling:resourceType": "latchd/templates/paragraph" }
		}).done(function(response,obj,a){ 
			 console.log("new paragraph saved!");
		}).fail(function(error){
			console.log("Error: "+error);
		});
	};

	var saveNewQuote = function(path,value,author){

		var data = {
			"sling:resourceType": "latchd/templates/quote"
		}

		if(value){
			data["value"] = value;
		}

		if(author){
			data["author"] = author;
		}

		$.ajax({
			type: "POST",
			url: path,
			data: data
		}).done(function(){
			 console.log("new quote saved!");
		}).fail(function(error){
			console.log("Error: "+error);
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
	
	var newParagraph = function(stringPath){
		var d = new Date();
		var ele = document.createElement("p");
		ele.innerText = "";
		ele.setAttribute("id",stringPath+"/");
		ele.setAttribute("contenteditable",true);
		ele.setAttribute("onblur","LatchD.saveNewParagraph(this);");
		$(ele).insertBefore("#byline");
		
		$(ele).focus();
		ele.scrollIntoView();
	};

	var newQuote = function(stringPath){
		var ele = document.createElement("blockquote");
		ele.innerText = "";
		ele.setAttribute("class","styl4");
		ele.setAttribute("onclick","LatchD.highlight(this);");

		var p = document.createElement("p");
		p.setAttribute("rel","quote");
		p.setAttribute("contenteditable",true);
		p.setAttribute("onblur","return LatchD.save('"+stringPath+"','value',this.innerText);");
		p.innerText = "Never look a gift horse in the mouth!";

		var div = document.createElement("div");
		div.setAttribute("class","blockquote");
		div.setAttribute("contenteditable",true);
		p.setAttribute("onblur","return LatchD.save('"+stringPath+"','author',this.innerText);");
		div.innerText = "The Horse - 2014";

		ele.appendChild(p);
		ele.appendChild(div);

		$(ele).insertBefore("#byline");

		saveNewQuote(stringPath+"/",p.innerText,div.innerText);

		$(ele).focus();
		ele.scrollIntoView();
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
	
	var setValue = function(path,name,value){
		var data = {};
		data[name] = value;
		
		$.ajax({
			type: "POST",
			url: path,
			data: data
		}).done(function(){
			 console.log(name+" : "+value+" saved to "+path);
			 $("img[id='"+path+"']").attr("src",value);
		}).fail(function(error){
			console.log("Error: "+error);
		});
	};
	
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
			clearFonts();
			setMainFont(style.main);
			setTitleFont(style.title);
		}
	};
	
	var justify = function(value){
		var ps = $("p[id]");
		if(value){
			ps.addClass("justified");
		}else{
			ps.removeClass("justified");
		}
	};
	
	var preToTextArea = function(item){
		var code = $(item.children[0]).text();
		$("item").hide();
		
		var ta = document.createElement("textarea");
		ta.setAttribute("class","topcoat-textarea");
		ta.setAttribute("rows",10);
		ta.setAttribute("cols",64);
		ta.setAttribute("id",item.id);
		ta.setAttribute("onblur","LatchD.exitCode(this);");
		$(ta).text(code);
		
		$(ta).insertBefore(item);
		$(ta).focus();
	};
	
	var exitCodeEdit = function(item){
		var id = item.id;
		var code = item.value;
		console.log(item);
		
		$("pre[id='"+id+"'] code").text(code);
		$("pre").show();
		$(item).remove();
		
		setValue(id,'value',code);
		
		Prism.highlightAll();
	};
	
	
	return {
		highlight: highlightSelection,
		find: findSelectedPara,
		paragraphChanged: paragraphChanged,
		newParagraph: newParagraph,
		newQuote: newQuote,
		saveNewParagraph: saveNewParagraph,
		saveNewQuote: saveNewQuote,
		dropcap: dropCap,
		indent: changeIndent,
		save: setValue,
		setTypography: setTypography,
		justify: justify,
		editCode: preToTextArea,
		exitCode: exitCodeEdit
	};
}();