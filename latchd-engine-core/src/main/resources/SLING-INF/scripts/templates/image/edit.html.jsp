<%@page session="false" import="org.apache.sling.api.resource.*, javax.jcr.*"%>
<%@taglib prefix="sling" uri="http://sling.apache.org/taglibs/sling"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<sling:defineObjects/>
<%
	ValueMap map = resource.adaptTo(ValueMap.class);
	String path = currentNode.getPath()+".picker.html";
%>
<c:set var="path" value="<%= currentNode.getPath() %>"/>
<c:set var="name" value="<%= currentNode.getName() %>"/>
<sling:include path='<%= path %>'/>
<div rel="image" class="captiondiv">
	<a href="#" data-toggle="modal" data-target="#modalview">
		<img src='<%= map.get("value") %>'
			 alt='<%= map.get("caption","") %>'
			 id="${path}"
			 class="img-responsive"
			 data-toggle="modal"
			 data-target="#<%= currentNode.getName() %>"/>
	</a>
	<span contenteditable=true
		 onblur="return LatchD.editmode.save('${path}','caption',this.innerText);"><%= map.get("caption","") %></span>
</div>
