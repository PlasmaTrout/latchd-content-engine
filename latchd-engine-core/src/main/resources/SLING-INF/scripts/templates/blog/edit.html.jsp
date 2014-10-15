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

<nav class="navbar navbar-fixed-top navbar-inverse" role="navigation">
	
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#mainnavbar">
	        <span class="sr-only">Toggle navigation</span>
	        <span class="icon-bar"></span>
	        <span class="icon-bar"></span>
	        <span class="icon-bar"></span>
		    </button>
		    <a class="navbar-brand" href="#">
		    	<img src="/static/img/LatchDHeader.png" style="height: 20px;" />
		    </a>
		</div>
		<div class="collapse navbar-collapse" id="#mainnavbar">
			<ul class="nav navbar-nav">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown">Document <span class="caret"></a>
		    		<ul class="dropdown-menu" role="menu">
		    			<li><a href="#" onclick="LatchD.newParagraph('${path}');">Add Paragraph</a></li>
		    			<li><a href="#">Add Image</a></li>
		    			<li><a href="#" onclick="return LatchD.newQuote('${path}');">Add Quote</a></li>
		    			<li><a href="#">Add Latch</a></li>
		    		</ul> 	
		    	</li>
		    	<li class="dropdown">
		    		<a href="#" class="dropdown-toggle" data-toggle="dropdown">Typography <span class="caret"></a>
		    		<ul class="dropdown-menu" role="menu">
		    			<li><a href="#" onclick="LatchD.setTypography(0);LatchD.save('${path}','typeset',0);">Georgia/Verdana (Default)</a></li>
		    			<li><a href="#" onclick="LatchD.setTypography(1);LatchD.save('${path}','typeset',1);">Baskerville/Source Sans</a></li>
		    			<li><a href="#" onclick="LatchD.setTypography(2);LatchD.save('${path}','typeset',2);">Garamond/Helvetica</a></li>
		    			<li><a href="#" onclick="LatchD.setTypography(3);LatchD.save('${path}','typeset',3);">Baskerville/Franklin Gothic</a></li>
		    			<li><a href="#" onclick="LatchD.setTypography(4);LatchD.save('${path}','typeset',4);">Garamond/Gills Sans</a></li>
    				</ul>
		    	</li>
			</ul>
		</div>
	</div>
</nav>

<div class="container-fluid">
<div class="row" style="margin-top: 80px;">
	<div class="col-md-1">
		&nbsp;
	</div>
	<div class="col-md-2" id="toolbelt">
		
		<div class="panel panel-primary">
		<div class="panel-heading">Formatting</div>
		<div class="panel-body">
			<div id="adjustments" class="checkbox">
				<label>
					<input type="checkbox" id="dropcapinput"
					 onchange="return LatchD.save('${path}','dropcap',this.checked);"
					 onclick="return LatchD.dropcap(this);" <%= map.get("dropcap",false) ? "checked" : "" %> >
					 Drop Caps
				</label>
			</div>
			<div class="checkbox">
				<label>
					<input type="checkbox" id="justifyinput"
					 onchange="return LatchD.save('${path}','justify',this.checked);"
					 onclick="return LatchD.justify(this.checked);" <%= map.get("justify",false) ? "checked" : "" %> >
					 Justify
				</label>
			</div>
			<div id="indentdiv" style="margin-top: 10px;">
				<span class="tool-label" id="indentspan">Indent Size <%= map.get("indent",0) %>px</span>
				<input type="range" id="indentrange"
				 value='<%= map.get("indent",0) %>'
				 oninput="return LatchD.indent(this.value);"
				 onchange="return LatchD.save('<%= currentNode.getPath() %>','indent',this.value);">
			</div>
			</div>
		</div>
		<div class="panel panel-primary">
			<div class="panel-heading">Add Content</div>
			<div class="panel-body">
				<div class="btn-toolbar" role="toolbar">
				<div class="btn-group">
					<button class="btn button-default"
					onclick="LatchD.newParagraph('${path}');">
						<span class="glyphicon glyphicon-plus"></span>
					</button>
					<button class="btn button-default"
						onclick="LatchD.newQuote('${path}');">
						<span class="glyphicon glyphicon-comment"></span>
					</button>
					<button class="btn button-default"
						onclick="LatchD.newImage('${path}');">
						<span class="glyphicon glyphicon-picture"></span>
					</button>
				</div>
			</div>
			</div>
		</div>
	</div>
	
	<div class="col-md-5">
		<h2 contenteditable=true
			class="header-verdana"
			id="headline"
			class="header-open-type"
			onblur="return LatchD.save('${path}','headline',this.innerText);"><%= map.get("headline") %></h2>
		<h5 contenteditable=true
			class="header-verdana"
			id="subheading"
			onblur="return LatchD.save('${path}','subheading',this.innerText);"><%= map.get("subheading") %></h5>
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
	<div class="col-md-4">
		&nbsp;
	</div>
	</div>
</div>
</div>
<sling:include path="/content/templates/footer.edit.html"/>
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

