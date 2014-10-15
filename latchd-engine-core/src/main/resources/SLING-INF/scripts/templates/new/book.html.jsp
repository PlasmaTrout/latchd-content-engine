<%@page session="false" import="org.apache.sling.api.resource.*, javax.jcr.*"%>
<%@taglib prefix="sling" uri="http://sling.apache.org/taglibs/sling"%>
<sling:defineObjects/>
<sling:include path="/content/templates/header.edit.html"/>
<div class="container">
	<div class="row" style="margin-top: 100px;">
		<h4>Create A New Book</h4>
		<p>A book is an ordered collection of chapters. It's ordered so that a table
		of contents can be generated for it. A book normally has a cover type along with
		forwards, appendixes and glossaries.</p>
		
	</div>
</div>
<sling:include path="/content/templates/footer.edit.html"/>