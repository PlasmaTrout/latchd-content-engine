<%@page session="false" import="org.apache.sling.api.resource.*, javax.jcr.*"%>
<%@taglib prefix="sling" uri="http://sling.apache.org/taglibs/sling"%>
<sling:defineObjects/>
<%
	ValueMap map = resource.adaptTo(ValueMap.class);
%>
<blockquote class="style4">
	<p rel="quote"><%= map.get("value") %><p>
	<div class="blockauthor"><%= map.get("source","") %></div>
</blockquote>