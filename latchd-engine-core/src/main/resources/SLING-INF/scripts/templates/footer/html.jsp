<%@page session="false" import="org.apache.sling.api.resource.*, javax.jcr.*"%>
<%@taglib prefix="sling" uri="http://sling.apache.org/taglibs/sling"%>
<sling:defineObjects/>
<%
	ValueMap map = resource.adaptTo(ValueMap.class);
%>

	<script src="/static/js/latchd.js"></script>
	
</body>
</html>