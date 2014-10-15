<%@page session="false" import="org.apache.sling.api.resource.*, javax.jcr.*"%>
<%@taglib prefix="sling" uri="http://sling.apache.org/taglibs/sling"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<sling:defineObjects/>
<%
	ValueMap map = resource.adaptTo(ValueMap.class);
%>
<c:set var="path" value="<%= currentNode.getPath() %>"/>
<c:set var="value" value='<%= map.get("value") %>'/>
<blockquote class="style4" onclick="LatchD.editmode.highlight(this);">
	<p rel="quote"
		contenteditable=true
		onblur="return LatchD.editmode.save('${path}','value',this.innerText);">${sling:encode(value,'HTML')}<p>
	<div class="blockauthor"
		contenteditable=true
		onblur="return LatchD.editmode.save('${path}','source',this.innerText);">
		<%= map.get("source","") %></div>
</blockquote>