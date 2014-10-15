<%@page session="false" import="org.apache.sling.api.resource.*, javax.jcr.*"%>
<%@taglib prefix="sling" uri="http://sling.apache.org/taglibs/sling/1.0"%>
<sling:defineObjects/>
<!DOCTYPE html>
<html>
	<head>
		<title>Blog Post</title>
		<link rel="stylesheet" href="/static/css/bootstrap.min.css"/>
		<link rel="stylesheet" href="/static/css/style.css"/>
		<link rel="stylesheet" href="/static/css/prism.css"/>
		<script src="/static/js/libs/jquery-2.0.2.min.js"></script>
		<script src="/static/js/libs/modernizr-2.6.2.min.js"></script>
		<script src="/system/sling.js"></script>
		<link href='http://fonts.googleapis.com/css?family=Libre+Baskerville' rel='stylesheet' type='text/css'>
		<link href='http://fonts.googleapis.com/css?family=Roboto:300,700' rel='stylesheet' type='text/css'>
		<link href='http://fonts.googleapis.com/css?family=Source+Sans+Pro:300,700' rel='stylesheet' type='text/css'>
	</head>
	<body>
