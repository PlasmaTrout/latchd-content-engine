<%@page session="false" import="org.apache.sling.api.resource.*, javax.jcr.*"%>
<%@taglib prefix="sling" uri="http://sling.apache.org/taglibs/sling"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<sling:defineObjects/>
<%
	ValueMap map = resource.adaptTo(ValueMap.class);
%>
<c:set var="path" value="<%= request.getContextPath()+currentNode.getPath() %>"/>
<div class="modal fade" id="<%= currentNode.getName() %>" role="dialog" aria-hidden="true" aria-labelledby="myModalLabel">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				<h4 class="modal-title" id="myModelLabel">Image Chooser</h4>
			</div>
			<div class="modal-body">
				<div data-bind="foreach: imagelist" style="height: 230px;overflow: auto;">
					<div style="float: left;">
						<img data-bind="attr{ src: path, id: path }"
							 style="height: 80px;"
							 onclick="LatchD.editmode.save('${path}','value',this.id,false,true);"/>
					</div>
				</div>
				<div style="clear: both"></div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal">Delete</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>
