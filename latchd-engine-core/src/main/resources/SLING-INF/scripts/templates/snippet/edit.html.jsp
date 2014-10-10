<%@page session="false" import="org.apache.sling.api.resource.*, javax.jcr.*"%>
<%@taglib prefix="sling" uri="http://sling.apache.org/taglibs/sling"%>
<sling:defineObjects/>
<%
	ValueMap map = resource.adaptTo(ValueMap.class);
%>
<pre class='language-<%= map.get("language","bash") %>'
	id="<%= currentNode.getPath() %>"
	data-line='<%= map.get("highlight",0) %>'
	onclick="return LatchD.editCode(this);">
	<code><%= map.get("value","") %></code>
</pre>
