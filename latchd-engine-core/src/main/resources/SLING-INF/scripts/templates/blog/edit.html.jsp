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
<div class="container-fluid">
<div class="row" style="margin-top: 80px;">
	<div id="modal-view" ng-view></div>
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
					 onchange="return LatchD.editmode.save('${path}','dropcap',this.checked);"
					 onclick="return LatchD.style.dropcap();" <%= map.get("dropcap",false) ? "checked" : "" %> >
					 Drop Caps
				</label>
			</div>
			<div class="checkbox">
				<label>
					<input type="checkbox" id="justifyinput"
					 onchange="return LatchD.editmode.save('${path}','justify',this.checked);"
					 onclick="return LatchD.style.justify(this.checked);" <%= map.get("justify",false) ? "checked" : "" %> >
					 Justify
				</label>
			</div>
			<div id="indentdiv" style="margin-top: 10px;">
				<span class="tool-label" id="indentspan">Indent Size <%= map.get("indent",0) %>px</span>
				<input type="range" id="indentrange"
				 value='<%= map.get("indent",0) %>'
				 oninput="return LatchD.style.indent(this.value);"
				 onchange="return LatchD.editmode.save('<%= currentNode.getPath() %>','indent',this.value);">
			</div>
			</div>
		</div>
		<div class="panel panel-primary">
			<div class="panel-heading">Add Content</div>
			<div class="panel-body">
				<div class="btn-toolbar" role="toolbar">
				<div class="btn-group">
					<button class="btn button-default"
					onclick="LatchD.editmode.newParagraph('${path}');">
						<span class="glyphicon glyphicon-plus"></span>
					</button>
					<button class="btn button-default"
						onclick="LatchD.editmode.newQuote('${path}');">
						<span class="glyphicon glyphicon-comment"></span>
					</button>
					<button class="btn button-default"
						onclick="LatchD.editmode.newImage('${path}');">
						<span class="glyphicon glyphicon-picture"></span>
					</button>
					<button class="btn button-default"
						onclick="LatchD.wordchecker.checkAll();">
						<span class="glyphicon glyphicon-wrench"></span>
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
			onblur="return LatchD.editmode.save('${path}','headline',this.innerText);"><%= map.get("headline") %></h2>
		<h5 contenteditable=true
			class="header-verdana"
			id="subheading"
			onblur="return LatchD.editmode.save('${path}','subheading',this.innerText);"><%= map.get("subheading") %></h5>
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
		<div class="panel panel-primary">
			<div class="panel-heading">Errors Key</div>
			<div class="panel-body" id="errors">
				<span class='label label-warning'>&nbsp;</span>&nbsp;Buzzword<br/>
				<span class='label label-primary'>&nbsp;</span>&nbsp;Fad<br/>
				<span class='label label-info'>&nbsp;</span>&nbsp;Hackneyed media writing
			</div>
		</div>
		<div class="panel panel-primary">
			<div class="panel-heading">Double Check</div>
			<div class="panel-body" id="defs">
				
			</div>
		</div>
	</div>
</div>
</div>
<sling:include path="/content/templates/footer.edit.html"/>
<%
	Boolean drop = map.get("dropcap",false);
	if(map.get("dropcap",false)){
		%><script>LatchD.style.dropcap();</script><%
	}
%>
<script>
	LatchD.style.indent(<%= map.get("indent",0) %>);
	LatchD.style.justify(<%= map.get("justify",false) %>);
	LatchD.style.setTypography(<%= map.get("typeset",0) %>);
	
</script>

