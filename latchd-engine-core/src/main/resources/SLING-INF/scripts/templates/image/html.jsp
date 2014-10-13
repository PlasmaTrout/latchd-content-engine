<%@page session="false" import="org.apache.sling.api.resource.*, javax.jcr.*"%>
<%@taglib prefix="sling" uri="http://sling.apache.org/taglibs/sling"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<sling:defineObjects/>
<%
	ValueMap map = resource.adaptTo(ValueMap.class);
%>
<c:set var="path" value="<%= currentNode.getPath() %>"/>
<div rel="image" class="captiondiv">
	<img src='<%= map.get("value") %>'
		 alt='<%= map.get("caption","") %>'
		 id="${path}"/>
	<span><%= map.get("caption","") %></span>
</div>