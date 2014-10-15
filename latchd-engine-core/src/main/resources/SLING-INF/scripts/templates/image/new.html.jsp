<%@page session="false" import="org.apache.sling.api.resource.*, javax.jcr.*"%>
<%@taglib prefix="sling" uri="http://sling.apache.org/taglibs/sling"%>
<sling:defineObjects/>
<sling:include path="/content/templates/header.edit.html"/>
<div class="container">
	<div class="row" style="margin-top: 100px;">
		<h4>Upload A New Photo</h4>
		<p>This tool uploads and stores a photo in the /uploads/images content section of the application.
		For right now any images uploaded here will be available in the image content block modal.</p>
		<form role="form" method="post" action="/uploads/images" enctype="multipart/form-data">
			<div class="form-group">
				<label for="headline">File</label>
				<input type="file" class="form-control" name="*"/>
				<input type="hidden" name="*@TypeHint" value="nt:file" />
			</div>
		<button type="submit" class="btn btn-default" onclick="return LatchD.newPost();">Create</button>
		</form>
	</div>
</div>
<sling:include path="/content/templates/footer.edit.html"/>