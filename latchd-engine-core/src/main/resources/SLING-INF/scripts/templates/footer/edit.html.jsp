<%@page session="false" import="org.apache.sling.api.resource.*, javax.jcr.*"%>
<%@taglib prefix="sling" uri="http://sling.apache.org/taglibs/sling"%>
<sling:defineObjects/>
<%
	ValueMap map = resource.adaptTo(ValueMap.class);
%>

	<script src="/static/js/latchd/latchd-style.js"></script>
	<script src="/static/js/latchd/latchd-editmode.js"></script>
	<script src="/static/js/prism.js"></script>
	<script src="/static/js/models/images_model.js"></script>
	 <script src="/static/js/bootstrap.min.js"></script>
</body>
</html>