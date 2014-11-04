<%@page session="false" import="org.apache.sling.api.resource.*, javax.jcr.*"%>
<%@taglib prefix="sling" uri="http://sling.apache.org/taglibs/sling"%>
<sling:defineObjects/>
<%
	ValueMap map = resource.adaptTo(ValueMap.class);
%>

<p id="<%= currentNode.getPath() %>"
	rel="contentblock"
	class="georgia"
	contenteditable="true"
	onblur="LatchD.editmode.paragraphChanged(this);"><%= map.get("value") %></p>
