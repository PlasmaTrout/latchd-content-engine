<%@page session="false" import="org.apache.sling.api.resource.*, javax.jcr.*"%>
<%@taglib prefix="sling" uri="http://sling.apache.org/taglibs/sling/1.0"%>
<sling:defineObjects/>
<!DOCTYPE html>
<html lang="en" ng-app="LatchDApp">
	<head>
		<link href='http://fonts.googleapis.com/css?family=Libre+Baskerville' rel='stylesheet' type='text/css'>
		<title>Blog Page</title>
		<link rel="stylesheet" href="/static/css/prism.css"/>
		<link rel="stylesheet" href="/static/css/bootstrap.min.css"/>
		<link rel="stylesheet" href="/static/css/style.css"/>
		<script src="/static/js/libs/jquery-2.0.2.min.js"></script>
		<script src="/static/js/libs/angular.min.js"></script>
		<script src="/static/js/libs/angular-route.min.js"></script>
		<script src="/static/js/app/app.js"></script>
		<script src="/static/js/app/controllers/controllers.js"></script>
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
					<a href="#" class="dropdown-toggle" data-toggle="dropdown">Document<span class="caret"></a>
		    		<ul class="dropdown-menu" role="menu">
		    			<li><a href="/content/docs/new.post.html">Create A New Blog Post</a></li>
		    			<li><a href="/content/docs/new.book.html">Create A New Book</a></li>
		    		</ul> 	
		    	</li>
		    	<li class="dropdown">
		    		<a href="#" class="dropdown-toggle" data-toggle="dropdown">Typography<span class="caret"></a>
		    		<ul class="dropdown-menu" role="menu">
		    			<li><a href="#" onclick="LatchD.style.setTypography(0);LatchD.editmode.save('${path}','typeset',0);">Georgia/Verdana (Default)</a></li>
		    			<li><a href="#" onclick="LatchD.style.setTypography(1);LatchD.editmode.save('${path}','typeset',1);">Baskerville/Source Sans</a></li>
		    			<li><a href="#" onclick="LatchD.style.setTypography(2);LatchD.editmode.save('${path}','typeset',2);">Garamond/Helvetica</a></li>
		    			<li><a href="#" onclick="LatchD.style.setTypography(3);LatchD.editmode.save('${path}','typeset',3);">Baskerville/Franklin Gothic</a></li>
		    			<li><a href="#" onclick="LatchD.style.setTypography(4);LatchD.editmode.save('${path}','typeset',4);">Garamond/Gills Sans</a></li>
    				</ul>
		    	</li>
		    	<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown">Resources<span class="caret"></a>
		    		<ul class="dropdown-menu" role="menu">
		    			<li><a href="/content/media/photo.new.html">Upload A Photo</a></li>
		    		</ul> 	
		    	</li>
			</ul>
			<% if(request.getAttribute("org.osgi.service.http.authentication.type") != null){ %>
				    <p class="navbar-text navbar-right">Signed in as <a href="/system/sling/logout" class="navbar-link"><%= request.getAttribute("org.osgi.service.http.authentication.remote.user") %></a></p>
					<ul class="nav navbar-nav">
						
					</ul>
				</div>
			<% } else { %>
				<form class="navbar-form navbar-right" role="form">
		            <div class="form-group">
		              <input id="username" type="text" placeholder="Email" class="form-control" autocomplete="off" style="background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAASCAYAAABSO15qAAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH3QsPDhss3LcOZQAAAU5JREFUOMvdkzFLA0EQhd/bO7iIYmklaCUopLAQA6KNaawt9BeIgnUwLHPJRchfEBR7CyGWgiDY2SlIQBT/gDaCoGDudiy8SLwkBiwz1c7y+GZ25i0wnFEqlSZFZKGdi8iiiOR7aU32QkR2c7ncPcljAARAkgckb8IwrGf1fg/oJ8lRAHkR2VDVmOQ8AKjqY1bMHgCGYXhFchnAg6omJGcBXEZRtNoXYK2dMsaMt1qtD9/3p40x5yS9tHICYF1Vn0mOxXH8Uq/Xb389wff9PQDbQRB0t/QNOiPZ1h4B2MoO0fxnYz8dOOcOVbWhqq8kJzzPa3RAXZIkawCenHMjJN/+GiIqlcoFgKKq3pEMAMwAuCa5VK1W3SAfbAIopum+cy5KzwXn3M5AI6XVYlVt1mq1U8/zTlS1CeC9j2+6o1wuz1lrVzpWXLDWTg3pz/0CQnd2Jos49xUAAAAASUVORK5CYII=); background-attachment: scroll; background-position: 100% 50%; background-repeat: no-repeat;">
		            </div>
		            <div class="form-group">
		              <input id="password" type="password" placeholder="Password" class="form-control" autocomplete="off" style="background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAASCAYAAABSO15qAAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH3QsPDhss3LcOZQAAAU5JREFUOMvdkzFLA0EQhd/bO7iIYmklaCUopLAQA6KNaawt9BeIgnUwLHPJRchfEBR7CyGWgiDY2SlIQBT/gDaCoGDudiy8SLwkBiwz1c7y+GZ25i0wnFEqlSZFZKGdi8iiiOR7aU32QkR2c7ncPcljAARAkgckb8IwrGf1fg/oJ8lRAHkR2VDVmOQ8AKjqY1bMHgCGYXhFchnAg6omJGcBXEZRtNoXYK2dMsaMt1qtD9/3p40x5yS9tHICYF1Vn0mOxXH8Uq/Xb389wff9PQDbQRB0t/QNOiPZ1h4B2MoO0fxnYz8dOOcOVbWhqq8kJzzPa3RAXZIkawCenHMjJN/+GiIqlcoFgKKq3pEMAMwAuCa5VK1W3SAfbAIopum+cy5KzwXn3M5AI6XVYlVt1mq1U8/zTlS1CeC9j2+6o1wuz1lrVzpWXLDWTg3pz/0CQnd2Jos49xUAAAAASUVORK5CYII=); background-attachment: scroll; background-position: 100% 50%; background-repeat: no-repeat;">
		            </div>
		            <button type="submit" class="btn btn-success" onclick="LatchD.editmode.login();">Sign in</button>
		        </form>
			<% } %>
		</div>
		 	
	</div>
</nav>
