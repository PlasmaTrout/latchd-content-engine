<%@page session="false" import="org.apache.sling.api.resource.*, javax.jcr.*"%>
<%@taglib prefix="sling" uri="http://sling.apache.org/taglibs/sling"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<sling:defineObjects/>
<%
	ValueMap map = resource.adaptTo(ValueMap.class);
%>
<c:set var="path" value="<%= currentNode.getPath() %>"/>
<div class="modal" id="<%= currentNode.getName() %>">
	<div class="content">
		<div class="row">
			<div class="eight columns centered text-center">
				<h2>Choose Image</h2>
				<div data-bind="foreach: imagelist" style="height: 230px;overflow: auto;">
					<div style="float: left;">
						<img data-bind="attr{ src: path, id: path }"
							 style="height: 80px;"
							 onclick="LatchD.save('${path}','value',this.id);"/>
					</div>
				</div>
				<div style="clear: both"></div>
				<p class="btn primary medium">
          			<a href="#" class="switch" gumby-trigger="|#<%= currentNode.getName() %>">Close Modal</a>
        		</p>
			</div>
		</div>
	</div>
</div>
