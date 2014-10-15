<%@page session="false" import="org.apache.sling.api.resource.*, javax.jcr.*"%>
<%@taglib prefix="sling" uri="http://sling.apache.org/taglibs/sling/1.0"%>
<sling:defineObjects/>
<!DOCTYPE html>
<html>
	<head>
		<link href='http://fonts.googleapis.com/css?family=Libre+Baskerville' rel='stylesheet' type='text/css'>
		<title>Blog Post</title>
		<link rel="stylesheet" href="/static/css/prism.css"/>
		<link rel="stylesheet" href="/static/css/bootstrap.min.css"/>
		<link rel="stylesheet" href="/static/css/style.css"/>
		<script src="/static/js/libs/jquery-2.0.2.min.js"></script>
		<script src="/static/js/libs/modernizr-2.6.2.min.js"></script>
		<script src="/static/js/libs/knockout-3.2.0.js"></script>
		<script src="/system/sling.js"></script>		
	</head>
	<body>
	<nav class="navbar navbar-fixed-top navbar-inverse" role="navigation">
	
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#mainnavbar">
	        <span class="sr-only">Toggle navigation</span>
	        <span class="icon-bar"></span>
	        <span class="icon-bar"></span>
	        <span class="icon-bar"></span>
		    </button>
		    <a class="navbar-brand" href="#">
		    	<img src="/static/img/LatchDHeader.png" style="height: 20px;" />
		    </a>
		</div>
		<div class="collapse navbar-collapse" id="#mainnavbar">
			<ul class="nav navbar-nav">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown">Document <span class="caret"></a>
		    		<ul class="dropdown-menu" role="menu">
		    			<li><a href="/content/docs/newpost.html">New Blog Post</a></li>
		    		</ul> 	
		    	</li>
		    	<li class="dropdown">
		    		<a href="#" class="dropdown-toggle" data-toggle="dropdown">Typography <span class="caret"></a>
		    		<ul class="dropdown-menu" role="menu">
		    			<li><a href="#" onclick="LatchD.setTypography(0);LatchD.save('${path}','typeset',0);">Georgia/Verdana (Default)</a></li>
		    			<li><a href="#" onclick="LatchD.setTypography(1);LatchD.save('${path}','typeset',1);">Baskerville/Source Sans</a></li>
		    			<li><a href="#" onclick="LatchD.setTypography(2);LatchD.save('${path}','typeset',2);">Garamond/Helvetica</a></li>
		    			<li><a href="#" onclick="LatchD.setTypography(3);LatchD.save('${path}','typeset',3);">Baskerville/Franklin Gothic</a></li>
		    			<li><a href="#" onclick="LatchD.setTypography(4);LatchD.save('${path}','typeset',4);">Garamond/Gills Sans</a></li>
    				</ul>
		    	</li>
			</ul>
		</div>
	</div>
</nav>