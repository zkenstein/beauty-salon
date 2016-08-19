<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@	taglib	prefix="c"	uri="http://java.sun.com/jsp/jstl/core"	%> 
<%@page import="java.util.List"%>
<%@page import="java.sql.Time"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="models.Category"%>
<%@page import="models.Service"%>  

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%= getServletContext().getAttribute("siteTitle") %> - <%= getServletContext().getAttribute("siteDescription") %></title>
<%@include file="styles.jsp" %>

<script>
  $( function() {
    $( "#datepicker" ).datepicker({ minDate: 1, maxDate: "+1M +10D", dateFormat: "yy-mm-dd" });
  } );
  </script>
  
</head>
<body>

<%@include file="navigation.jsp" %>
<% List<Time[]> bookedTimes = (List<Time[]>) request.getAttribute("bookedTimes"); %>

<section id="treatments">
	<div class="wrapper">
		
		<h2>Book a visit </h2>
		
		<h3>Selected treatment:</h3>
		<c:out value="${service.name}"/>
		<p><c:out value="${service.description}"/></p>
		<p>Price: <c:out value="${service.price}"/> DKK</p>
		<p>Duration: <c:out value="${service.time}"/> hours</p>
	
	
		<h3>Booking data:</h3>
		
		<form method="post" action="booking?page=success">
			<div class="row">
				<div class="col-md-6">
					<div class="form-group">
						<label>First name</label>
						<input type="text" name="firstName" class="form-control" placeholder="Your first name" />
					</div>
				</div>
				<div class="col-md-6">
					<div class="form-group">
						<label>Last name</label>
						<input type="text" name="lastName" class="form-control" placeholder="Your last name" />
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-6">
					<div class="form-group">
						<label>Email address</label>
					    <input type="email" name="email" class="form-control" placeholder="Your email">
					</div>
				</div>
				<div class="col-md-6">
					<div class="form-group">
						<label>Phone number</label>
						<input type="phone" name="phone" class="form-control" placeholder="Your phone number" />
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-6">
					<div class="form-group">
						<label>Choose an employee</label>
						<select class="form-control" id="employeeId" name="employeeId">
							<c:forEach items="${employees}" var="employee">
								<option value="<c:out value="${employee.id}"/>"><c:out value="${employee.firstName}"/> <c:out value="${employee.lastName}"/></option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="col-md-6">
					<div class="form-group">
						<label>Choose a date</label>
						<input type="text" name="date" id="datepicker" class="form-control">
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-6">
					<div class="form-group">
						<label>Choose an hour</label><br/>
						
						<div id="bookingHour">
						<%	
							Calendar availableTime = new GregorianCalendar(2016,8,20,9,00,00);
						
							for (int i = 0; i < 17; i++) { 
							
								String buttonClass = "btn-success";
								
								for (Time[] time : bookedTimes) { 
									Time startTime = time[0];
									
									int startTimeHours = startTime.getHours();
									int startTimeMinutes = startTime.getMinutes();
									Calendar bookedTime = new GregorianCalendar(2016,8,20,startTimeHours,startTimeMinutes,00);
									
									Time duration = time[1];
									int durationHours = duration.getHours();
									int durationMinutes = duration.getMinutes();
									
									Calendar bookedTimeEnd = new GregorianCalendar(2016,8,20,startTimeHours,startTimeMinutes,00);
									bookedTimeEnd.add(Calendar.HOUR_OF_DAY, durationHours);
									bookedTimeEnd.add(Calendar.MINUTE, durationMinutes);

									if (availableTime.after(bookedTime) && availableTime.before(bookedTimeEnd)) {
										buttonClass = "btn-danger disabled";
									}
									else if (availableTime.equals(bookedTime) || availableTime.equals(bookedTimeEnd)) {
										buttonClass = "btn-danger disabled";
									}
								}
								
								int myHour = availableTime.get(Calendar.HOUR_OF_DAY);
								
								String myMinute;
								if (availableTime.get(Calendar.MINUTE) == 0) { 
									myMinute = "00";
								} 
								else { 
									myMinute = String.valueOf(availableTime.get(Calendar.MINUTE));
								}
								
								%>
								
								<a class="btn <%= buttonClass %>" role="button" data-hour="<%= myHour %>:<%= myMinute %>:00"><%= myHour %>:<%= myMinute %></a>

								<% 
								
								availableTime.add(Calendar.MINUTE, 30);	
							}
						%>
						</div>
	
						<input id="hour" type="hidden" name="time" value="09:00" />
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12">
					<% Service service = (Service) request.getAttribute("service"); %>
					<input type="hidden" name="serviceId" value="<c:out value="${service.id}"/>">
					<input id="duration" type="hidden" name="duration" value="<%= service.getTime() %>">
					<input type="submit" value="Book the visit" class="btn btn-primary btn-lg" />
				</div>
			</div>
		</form>
		
		
	</div>
</section>

<script>
	
	$(document).ready(function() {
		
		$('#datepicker').datepicker('setDate', new Date());
		$('#datepicker').on("change", function() {
			getData();
		}); 
		$('#employeeId').on("change", function() {
			getData();
		}); 
		
		$(document).on('click', '.btn-success', function() {
			console.log('CLIKED TO BOOK');
			var hour = $(this).attr('data-hour');
			console.log('the hour is: ' + hour);
			$('#hour').val(hour);
		})
		
		function getData() {
			var date = $('#datepicker').val();
			var employeeId = $('#employeeId').val();
			var duration = $('#duration').val();
			
			console.log("Date: " + date + " Employee id: " + employeeId);
			
			$.ajax({
				url: 'booking',
				method: 'post', 
				data: {'page':'ajax', 'date': date, 'employeeId': employeeId, 'duration': duration},
				success: function(responseText) {
					console.log("hejka");
					$('#bookingHour').html(responseText);
				}
			});
		}
	});	

</script>


<%@include file="footer.jsp" %>

</body>
</html>