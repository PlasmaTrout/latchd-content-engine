<%@page session="false" import="org.apache.sling.api.resource.*, javax.jcr.*"%>
<%@taglib prefix="sling" uri="http://sling.apache.org/taglibs/sling"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<sling:defineObjects/>
<sling:include path="/content/templates/header.edit.html"/>
<%
	ValueMap map = resource.adaptTo(ValueMap.class);
	NodeIterator it = currentNode.getNodes();
%>
<c:set var="path" value="<%= currentNode.getPath() %>"/>

<div class="navbar" id="nav1" gumby-fixed="top">
	<a class="toggle" gumby-trigger="#nav1 > ul" href="#"><i class="icon-menu"></i></a>
	<h1 class="four columns logo">
	    <a href="#">
	      <img src="/static/img/LatchDHeader.png" style="margin-left: 10px;margin-top: 3px;"/>
	    </a>
	</h1>
	<ul class="eight columns">
    	<li><a href="#">Document</a>
    	<div class="dropdown">
    		<ul>
    			<li><a href="#">Add Paragraph</a></li>
    			<li><a href="#">Add Image</a></li>
    			<li><a href="#">Add Quote</a></li>
    			<li><a href="#">Add Latch</a></li>
    		</ul>
    	</div>
    	</li>
    	<li><a href="#">Show Adjustments</a></li>
    	<li><a href="#">Style</a>
    		<div class="dropdown">
    			<ul>
	    			<li><a href="#" onclick="return LatchD.setTypography(0);">Georgia/Roboto (Default)</a></li>
	    			<li><a href="#" onclick="return LatchD.setTypography(1);">Baskerville/Source Sans</a></li>
    			</ul>
    		</div>
    	</li>
    </ul>
</div>	

<div class="row" style="margin-top: 80px;">
	<div class="two columns">
		<h1>&nbsp;</h1>
		<div id="adjustments">
			<label class="topcoat-switch">
				<input type="checkbox" class="topcoat-switch__input" id="dropcapinput"
				 onchange="return LatchD.save('${path}','dropcap',this.checked);"
				 onclick="return LatchD.dropcap(this);" <%= map.get("dropcap",false) ? "checked" : "" %> >
				<div class="topcoat-switch__toggle"></div>
			</label>
			<span class="tool-label">&nbsp;Drop Caps</span>
		</div>
		<div>
			<label class="topcoat-switch">
				<input type="checkbox" class="topcoat-switch__input" id="justifyinput"
				 onchange="return LatchD.save('${path}','justify',this.checked);"
				 onclick="return LatchD.justify(this.checked);" <%= map.get("justify",false) ? "checked" : "" %> >
				<div class="topcoat-switch__toggle"></div>
			</label>
			<span class="tool-label">&nbsp;Justify</span>
		</div>
		<div id="indentdiv" style="margin-top: 10px;text-align: justify;">
			<span class="tool-label" id="indentspan">Indent Size <%= map.get("indent",0) %>px</span>
			<input type="range" class="topcoat-range" id="indentrange"
			 value='<%= map.get("indent",0) %>'
			 oninput="return LatchD.indent(this.value);"
			 onchange="return LatchD.save('<%= currentNode.getPath() %>','indent',this.value);">
		</div>
	</div>
	<div class="eight columns">
		<h2 contenteditable=true
			class="header-roboto"
			id="headline"
			class="header-open-type"
			onblur="return LatchD.save('${path}','headline',this.innerText);"><%= map.get("headline") %></h2>
		<h5 contenteditable=true
			class="header-roboto"
			id="subheading"
			onblur="return LatchD.save('${path}','subheading',this.innerText);"
			style="margin-top: -10px;margin-left: 6px;margin-bottom:20px;"><%= map.get("subheading") %></h5>
		<%
			while(it.hasNext()){
				Node node = it.nextNode();
				String path = node.getPath()+".edit.html";
				%><sling:include path="<%= path %>"/><%
			}
		%>
		<p id="byline">October 10, 2014 - <%= map.get("author") %></p>
		<p>Edit Mode</p>
	</div>
	<div class="two columns">
		<h2>&nbsp;</h2>
		<button class="topcoat-icon-button--large" onclick="return LatchD.newParagraph('<%= currentNode.getPath() %>');">
			<span class="topcoat-icon--large" style="background-color:#A5A7A7;"></span>
		</button>
	</div>
</div>
<sling:include path="/content/templates/footer.html"/>
<%
	Boolean drop = map.get("dropcap",false);
	if(map.get("dropcap",false)){
		%><script>LatchD.dropcap();</script><%
	}
%>
<script>
	LatchD.indent(<%= map.get("indent",0) %>);
	LatchD.justify(<%= map.get("justify",false) %>);
	LatchD.setTypography(<%= map.get("typeset",0) %>);
</script>

