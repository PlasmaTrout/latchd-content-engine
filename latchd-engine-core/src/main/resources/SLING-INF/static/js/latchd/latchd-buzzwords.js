
LatchD.wordchecker = function(){
	
	var lists = Sling.getContent("/content/dictionaries/wordlists");
	var trickywords = Sling.getContent("/content/dictionaries/trickywords");
		
	var wordcheck2 = function(list,para,errorcolor,errorText){
		var text = para.innerHTML;
		list.forEach(function(word,index){
			var searchtext = text.toLowerCase();
			if(searchtext.indexOf(word) != -1){
				
				// Standard replace
				text = text.replace(word,generateTags(word,errorcolor,errorText));
				
				// Brute forces capitalized instanced of the word
				var uword = word[0].toUpperCase()+word.substring(1);
				text = text.replace(uword,generateTags(uword,errorcolor,errorText));
			    flagText(errorText,"warning");	
			}
		});
		para.innerHTML = text;
	};
	
	var generateTags = function(word, errorcolor,errorText){
		var newword = "<font data-placement='right' data-toggle='tooltip' color='"+errorcolor+"'"+
				" title='"+errorText+"'>"+word+"</font>";
		return newword;
	};
	
	var trickCheck = function(para){
		var text = para.innerHTML;
		trickywords.rules.forEach(function(rule){
			var ruleObj = JSON.parse(rule);
			ruleObj.words.forEach(function(word){
				if(text.indexOf(word) != -1){
					var newword = "<font data-placement='right' data-toggle='tooltip' style='text-decoration: underline;'"+
					" title='Frequently misused word, see definitions on right panel'>"+word+"</font>";
					text = text.replace(word,newword);
					createWarning(ruleObj);
				}
			});
		});
		para.innerHTML = text;
	};

    var flagText = function(msg, level){
        var div = document.createElement("div");
        div.setAttribute("class","alert alert-"+level);
        div.setAttribute("role","alert");
        div.innerText = msg;
        document.querySelector("#alerts-div").appendChild(div);
    };
	
	var createWarning = function(checkObj){
		var div = document.createElement("div");
		div.setAttribute("class","alert alert-info");
		div.setAttribute("role","alert");
		
		var dl = document.createElement("dl");
		for(var i = 0; i < checkObj.words.length; i++){
			var dt = document.createElement("dt");
			var dd = document.createElement("dd");
			
			dt.innerHTML = checkObj.words[i];
			dl.appendChild(dt);
			
			dd.innerHTML = checkObj.usage[i];
			dl.appendChild(dd);
			
		}
		
		div.appendChild(dl);
		
		document.querySelector("#alerts-div").appendChild(div);


	};
	
	var clearWarnings = function(){
		var dls = document.querySelectorAll("div[role=alert],dl");
		if(dls){
			for(var x = 0; x < dls.length; x++){
				dls[x].remove();
			}
		}
	}
	
	var checkWordLists = function(para){
		wordcheck2(lists.buzzwords,para,'#f0ad4e','Buzzword, consider replacing');
		wordcheck2(lists.mediawords,para,'#5bc0de','Media lingo, consider replacing');
		wordcheck2(lists.fadwords,para,'#428bca','Fad or cliche, consider replacing');
	};
	
	var checkAll = function(){
		clearWarnings();
		var paras = $("p[id]");
		paras.each(function(idx,para){
			checkWordLists(para);
			trickCheck(para);
		});
		$("font").tooltip()
	};
	
	var checkPara = function(para){
		checkWordLists(para);
		trickCheck(para);
		$("font").tooltip()
	}
	
	return {
		wordlist: lists,
		trickwords: trickywords,
		checkAll: checkAll,
		checkPara: checkPara
	}
	
}();
