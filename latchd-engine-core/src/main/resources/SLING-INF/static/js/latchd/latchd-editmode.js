LatchD.editmode = function(){
	
	var clearSelections = function(){
		var paras = $("p[id],blockquote");
		paras.each(function(ix,item){
			$(item).removeClass("paraselect");
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
			
			var data = { value: item.innerText };
			
			
			// If we have a blank paragraph delete it, this is the primary way
			// to remove content
			if(!item.innerText){
				toastr.info("Blank paragraphs are being deleted","Deleting");
				data[":operation"]="delete";
			}else{
				toastr.info("Paragraph was changed","Saving");
			}
			
			$.ajax({
				type: "POST",
				url: item.id,
				data: data,
			}).done(function(){
				 //LatchD.wordchecker.checkPara(item);
				
				 if(!item.innerText){
					 window.location.reload();
				 }
				 
			}).fail(function(error){
				toastr.error(error,"Error");
			});
		}
	};
	
	var login = function(successPath){
		var object = {
			j_username: "",
			j_password: "",
			"_charset_": "UTF-8",
			"resource": successPath
		};
		
		object.j_username = $("#username")[0].value;
		object.j_password = $("#password")[0].value;
	    console.log("logging in!");

		$.ajax({
			type: "POST",
			url: "/j_security_check",
			data: object,
		}).done(function(result){
			console.log(result);
			window.location.href=successPath;
		}).fail(function(error){
            console.log(error);
			toastr.error(error,"Error");
		});
	}
	
	var saveNewParagraph = function(item){
		if(item.innerText){
			$.ajax({
				type: "POST",
				url: item.id,
				data: { value: item.innerText, "sling:resourceType": "latchd/templates/paragraph" }
			}).done(function(response,obj,a){ 
				 console.log("new paragraph saved!");
				 
			}).fail(function(error){
				toastr.error(error,"Error");
			});
		}else{
			window.location.reload();
		}
	};
	
	var saveNewItem = function(item,resourceType){
		$.ajax({
			type: "POST",
			url: item.id,
			data: { value: item.innerText, "sling:resourceType": resourceType }
		}).done(function(response,obj,a){ 
			 toastr.info("New "+resoureType,"Saving");
			 console.log("new "+resourceType+" saved to "+item.id);
			 window.location.reload();
		}).fail(function(error){
			toastr.error(error,"Error");
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
			toastr.error(error,"Error");
		});
	};

    var updateQuote = function(path,value,author){
        if(value){
            setValue(path,'value',value);
        }else{
            setValue(path,'','',true);
        }

        if(author){
            setValue(path,'author',author);
        }
    };
	
	var newParagraph = function(stringPath,section){
		var ele = document.createElement("p");
		ele.innerText = "New paragraph!";
		ele.setAttribute("id",stringPath+"/");
		ele.setAttribute("contenteditable",true);
		ele.setAttribute("onblur","LatchD.editmode.saveNewParagraph(this);");
		
		$("#"+section+"-content").append(ele);
		
		LatchD.style.refreshTypography();
		$(ele).focus();
		ele.scrollIntoViewIfNeeded();
	};
	
	var newSnippet = function(path){
		var data = {
			"sling:resourceType": "latchd/templates/snippet",
			value: "System.out.println(\"Hello World\");",
			language: "java",
			"jcr:primaryType": "nt:unstructured"
		}
		$.ajax({
			type: "POST",
			url: path+"/",
			data: data
		}).done(function(){
			 console.log("new image saved!");
			 window.location.reload();
		}).fail(function(error){
			toastr.error(error,"Error");
		});
	};
	
	var newHeader = function(stringPath){
		var ele = document.createElement("h2");
		ele.innerText = "New Section";
		ele.setAttribute("id",stringPath+"/");
		ele.setAttribute("contenteditable",true);
		ele.setAttribute("onblur","LatchD.editmode.saveNewItem(this,'latchd/templates/section');");
		$(ele).insertBefore("p[rel=byline]");
		LatchD.style.refreshTypography();
		$(ele).focus();
		ele.scrollIntoViewIfNeeded();
	};
	
	var newImage = function(path){
		var data = {
				"sling:resourceType": "latchd/templates/image",
				value: "/uploads/images/steps.jpg",
				caption: "Indiatlantic Beach Entrance - July 2014"
			}

			$.ajax({
				type: "POST",
				url: path+"/",
				data: data
			}).done(function(){
				 console.log("new image saved!");
				 window.location.reload();
			}).fail(function(error){
				toastr.error(error,"Error");
			});
	};

	var newQuote = function(stringPath){
		var ele = document.createElement("blockquote");
		ele.innerText = "";
		ele.setAttribute("class","styl4");
		ele.setAttribute("onclick","LatchD.editmode.highlight(this);");

		var p = document.createElement("p");
		p.setAttribute("rel","quote");
		p.setAttribute("contenteditable",true);
		p.setAttribute("onblur","return LatchD.editmode.save('"+stringPath+"','value',this.innerText);");
		p.innerText = "Never look a gift horse in the mouth!";

		var div = document.createElement("div");
		div.setAttribute("class","blockquote");
		div.setAttribute("contenteditable",true);
		p.setAttribute("onblur","return LatchD.editmode.save('"+stringPath+"','author',this.innerText);");
		div.innerText = "The Horse - 2014";

		ele.appendChild(p);
		ele.appendChild(div);

		$(ele).insertBefore("p[rel=byline]");

		saveNewQuote(stringPath+"/",p.innerText,div.innerText);

		$(ele).focus();
		ele.scrollIntoViewIfNeeded();
	}
	
	var setValue = function(path,name,value,isDelete,isImage){
		var data = {};
	
		if(isDelete){
			data[":operation"]="delete";
		}else{
			data[name] = value;
		}
		
		$.ajax({
			type: "POST",
			url: path,
			data: data
		}).done(function(){
			 
			 if(isDelete){
				 console.log(path+" was deleted!");
				 toastr.info("Object was deleted","Deleted");
				 window.location.reload();
			 }else{
				 toastr.info("Object changed to "+value,"Saved");
				 console.log(name+" : "+value+" saved to "+path);

                 // If the update was an image, find the img block and change the src
                 // so the user can see the change.
                 if(isImage){
				    $("img[id='"+path+"']").attr("src",value);
                 }
			 }
		}).fail(function(error){
			toastr.error(error,"Error");
		});
	};
	
	var newPost = function(){
		var date = new Date();
		var year = date.getFullYear();
		var month = date.getMonth();
		var path = "/content/docs/"+year+"/"+month+"/";
		var data = {
			dropcap: false,
			headline: $("#headline")[0].value,
			subheading: $("#subheading")[0].value,
			justify: true,
			typeset: 0,
			author: Sling.getSessionInfo().userID,
			"sling:resourceType": "latchd/templates/blog",
			"jcr:title": $("#headline")[0].value,
			"jcr:primaryType": "nt:unstructured"
		}
		
		$.ajax({
			type: "POST",
			url: path,
			headers: {
				"Accept": "application/json,/;q=0.9"
			},
			data: data
		}).done(function(item){
			 console.log("new post saved! "+item);
			 window.location.href = item.path+".edit.html";
			 
		}).fail(function(error){
			toastr.error(error,"Error");
		});
	}
	
	var preToTextArea = function(item){
		var code = $(item.children[0]).text();
		$("item").hide();
		
		var ta = document.createElement("textarea");
		ta.setAttribute("class","topcoat-textarea");
		ta.setAttribute("rows",10);
		ta.setAttribute("cols",64);
		ta.setAttribute("id",item.id);
		ta.setAttribute("onblur","LatchD.editmode.exitCode(this);");
	
        if(item.id.indexOf("sling:") != -1){
            $(ta).text(item.id);
        }else{
            $(ta).text(code);
        }
		
		$(ta).insertBefore(item);
		$(ta).focus();
	};
	
	var exitCodeEdit = function(item){
		var id = item.id;
		var code = item.value;
		
		$("pre[id='"+id+"'] code").text(code);
		$("pre").show();
		$(item).remove();
		
		if(code){
			setValue(id,'value',code);
			if(code.substring(0,6) === "sling:"){
				setValue(id,'file',code.substring(6));
				window.location.reload();
			}else{
				setValue(id,'file','');
			}
		}else{
			console.log("snippet was blank, switching to delete mode!");
			setValue(id,'','',true);
			window.location.reload();
		}
		
		Prism.highlightAll();
	};
	
	return {
		highlight: highlightSelection,
		find: findSelectedPara,
		paragraphChanged: paragraphChanged,
		newParagraph: newParagraph,
		newQuote: newQuote,
		newHeader: newHeader,
		saveNewParagraph: saveNewParagraph,
		saveNewQuote: saveNewQuote,
		saveNewItem: saveNewItem,
		newImage: newImage,
		newSnippet: newSnippet,
        updateQuote: updateQuote,
		save: setValue,
		editCode: preToTextArea,
		exitCode: exitCodeEdit,
		newPost: newPost,
		login: login
	};
	
}();
