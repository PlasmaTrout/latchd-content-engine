<%@page session="false" import="org.apache.sling.api.resource.*, javax.jcr.*"%>
<%@taglib prefix="sling" uri="http://sling.apache.org/taglibs/sling"%>
<sling:defineObjects/>
<sling:include path="/content/templates/header.edit.html"/>
<div class="container">
	<div class="row" style="margin-top: 100px;">
		<h4>Create A New Posting</h4>
		<p>A posting is just a blog or article that will be saved according the year and month it was made. 
		These will typically be ordered with the most current first and be available on a users document page</p>
		<form role="form" id="newpostform">
			<div class="form-group">
				<label for="headline">Heading</label>
				<input type="text" class="form-control" id="headline" name="headline" placeholder="Your Heading Here">
			</div>
			<div class="form-group">
				<label for="subheading">Subheading</label>
				<input type="text" class="form-control" id="subheading" name="subheading" placeholder="Your Heading Here">
			</div>
			
			<input type="hidden" name="dropcap" value="false">
			<input type="hidden" name="typeset" value="1">
			<input type="hidden" id="author" name="author" value="J.Downing">
			<input type="hidden" name="jcr:title" value="new post" id="title">
			<input type="hidden" name="sling:resourceType" value="latchd/templates/blog">
		</form>
		<button type="submit" class="btn btn-default" onclick="return LatchD.editmode.newPost();">Create</button>
	</div>
</div>
<sling:include path="/content/templates/footer.edit.html"/>