<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*" %>
<%@  page import="java.sql.*,javax.sql.*,java.util.Date"%>
<%@ page import="java.text.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>LeaderSearch</title>

<link rel="stylesheet" type="text/css" href="dataReq/style.css">
<script type="text/javascript" src="dataReq/jquery1x.js"></script>
<script type="text/javascript" src="dataReq/script2.js"></script>
<script type="text/javascript" src="dataReq/jquery-ui.js" ></script>
<link rel="stylesheet" href="dataReq/date.css" type="text/css" />
<link rel="stylesheet" href="dataReq/formStyle.css" type="text/css" />
<script>
function openPage(pageURL)
{
	window.location.href = pageURL;
}
$(document).ready(function(){
$("#datepickerID").datepicker({dateFormat:'dd.mm.yy'});
$("#datepickerID1").datepicker({dateFormat:'dd.mm.yy'});
$("#datepickerID2").datepicker({dateFormat:'dd.mm.yy'});
$("#datepickerID3").datepicker({dateFormat:'dd.mm.yy'});
$("#datepickerID4").datepicker({dateFormat:'dd.mm.yy'});
$("#datepickerID5").datepicker({dateFormat:'dd.mm.yy'});
});
</script>
</head>
<body>
<%
	Date dat1=new Date();
	SimpleDateFormat ft =new SimpleDateFormat("E dd.MM.yyyy 'at' hh:mm:ss a zzz"); 
	String date=ft.format(dat1).toString().substring(4,14);
	String time=ft.format(dat1).toString().substring(18);
	%>


<div id="wrapper">
<div id="header">
<div id="logo">
<h1>
Analytics e-Data Request
</h1>
</div>

</div>
<div id="menu">
<ul>
<li><input type="button" class="btn" value="Homepage" onclick="openPage('leaderHome.jsp')"/></li>
</ul>
</div>
<div  align="right" id="menu2">
<center>
<ul>
<li><i>Date:<%out.println(date);%></i></li>
<li><i>Time:<%out.println(time);%></i></li>
</ul>
</center>
</div>
<div id="page">
<div class="admin">
<h2 align="center" style="color:blue"><i> Please enter the Date details </i></h2>
</div>
<br/>
<form action="GLdate.jsp" method="post">
<center>
<i>StartDate :</i><input type="text" name="Gdates" id="datepickerID4">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<i>EndDate :</i>
<input type="text"  name="Gdatee"id="datepickerID5">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="submit" class="btns" value="Submit Query">
</center>
</form>



</div>
<div id="page-bottom">
<marquee><i>State Bank of India,Analytics Department</i></marquee>
</div>
</div>
</body>
</html>