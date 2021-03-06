<%@page import="controller.WebsiteController"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@	taglib	prefix="c"	uri="http://java.sun.com/jsp/jstl/core"	%> 
<%@page import="java.util.List"%>
<%@page import="models.Category"%>  

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%= getServletContext().getAttribute("siteTitle") %> - <%= getServletContext().getAttribute("siteDescription") %></title>
<%@include file="jsp/styles.jsp" %>
</head>
<body>

<%@include file="jsp/navigation.jsp" %>
<% List<Category> categories = (List<Category>) request.getAttribute("categories"); %>

<section id="home">
	<div class="fade-bg">
		<div class="wrapper">
			<div class="row">
				<div class="col-md-12">
					<h1 class="text-center"><%= getServletContext().getAttribute("siteTitle") %></h1>
					<h4><%= getServletContext().getAttribute("siteDescription") %></h4>
					<a class="btn btn-primary btn-lg" href="#" role="button">Book a visit</a>
				</div>
			</div>
		</div>
	</div>
</section>

<section class="features">
	<div class="wrapper">
		<div class="row">
			<div class="col-md-2">
				<img src="img/logos/kerastase.png" />
			</div>
			<div class="col-md-2">
				<img src="img/logos/thebodyshop.png" />
			</div>
			<div class="col-md-2">
				<img src="img/logos/clinique.png" />
			</div>
			<div class="col-md-2">
				<img src="img/logos/dkny.png" />
			</div>
			<div class="col-md-2">
				<img src="img/logos/dior.png" />
			</div>
			<div class="col-md-2">
				<img src="img/logos/kerastase.png" />
			</div>
		</div>
	</div>
</section>

<section id="about" class="half-picture right" style="background-image: url('img/face2.jpg');">
	<div class="wrapper">
		<div class="row">
			<div class="col-md-6 solid-bg">
				<h1>Renew your energy</h1>
				<p>Take some time out and immerse yourself in the soothing, calm ambience of our Wellness Centre. We understand that health signifies one’s overall wellbeing, both physically and mentally, and that active people also need to relax and recharge their batteries in order to maintain and increase vitality.</p>
				<a class="btn btn-primary btn-lg" href="#" role="button">Book a visit</a>
			</div>
		</div>
	</div>
</section>

<section id="about" class="half-picture" style="background-image: url('img/spa.jpg');">
	<div class="wrapper">
		<div class="row">
			<div class="col-md-offset-6 col-md-6 solid-bg">
				<h1>Treatments for everyone</h1>
				<p>Take some time out and immerse yourself in the soothing, calm ambience of our Wellness Centre. We understand that health signifies one’s overall wellbeing, both physically and mentally, and that active people also need to relax and recharge their batteries in order to maintain and increase vitality.</p>
				<a class="btn btn-primary btn-lg" href="#" role="button">Book a visit</a>
			</div>
		</div>
	</div>
</section>

<section id="treatments">
	<div class="wrapper">
		<div class="row">
			<div class="col-md-12 text-center">
				<h1 class="text-center">Our treatments</h1>
				<h4>Choose from our range of relaxing treatments and massages.</h4>
				<br/><br/><br/><br/>
			</div>
		</div>
		
		<div class="row">
			<div class="col-md-12">
				<c:forEach items="${categories}" var="category">
					<a href="?page=category&id=<c:out value="${category.id}"/>">
						<div class="col-md-4 text-center treatment" style="background-image: url('<%= Helpers.getBaseUrl(request) %>/uploads/categories/<c:out value="${category.picture}"/>')")>
							<div class="fade-effect">
								<h2><c:out value="${category.name}"/></h2>
							</div>
						</div>
					</a>
				</c:forEach>
			</div>
		</div>		
		
	</div>
</section>

<%@include file="jsp/calltoaction.jsp" %>

<%@include file="jsp/footer.jsp" %>

</body>
</html>