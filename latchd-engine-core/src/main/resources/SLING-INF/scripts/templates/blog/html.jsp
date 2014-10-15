<%@page session="false" import="org.apache.sling.api.resource.*, javax.jcr.*"%>
<%@taglib prefix="sling" uri="http://sling.apache.org/taglibs/sling"%>
<sling:defineObjects/>
<sling:include path="/content/templates/header.html"/>
<%
	ValueMap map = resource.adaptTo(ValueMap.class);
	NodeIterator it = currentNode.getNodes();
%>
<div class="container">
	<div class="row">
		<div class="col-md-7 col-md-offset-2">
			<h2 id="headline"><%= map.get("headline") %></h2>
			<h5 id="subheading"><%= map.get("subheading") %></h5>
			<%
				while(it.hasNext()){
					Node node = it.nextNode();
					String path = node.getPath()+".html";
					%><sling:include path="<%= path %>"/><%
				}
			%>
			<p>October 10, 2014 - <%= map.get("author") %></p>
		</div>
	</div>
</div>

<sling:include path="/content/templates/footer.html"/>
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
