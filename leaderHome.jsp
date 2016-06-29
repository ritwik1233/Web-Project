<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*" %>
<%@  page import="java.sql.*,javax.sql.*,java.util.Date"%>
<%@ page import="java.text.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>LeaderHome</title>
<link rel="stylesheet" type="text/css" href="dataReq/style.css">
<script type="text/javascript" src="dataReq/jquery1x.js"></script>
<script type="text/javascript" src="dataReq/script2.js"></script>
<script type="text/javascript" src="dataReq/jquery-ui.js" ></script>
<link rel="stylesheet" href="dataReq/date.css" type="text/css" />
<link rel="stylesheet" href="dataReq/formStyle.css" type="text/css" />
<script type="text/javascript">
$(document).ready(function(){
	$(".admin").hide();
	$(".admin").show(1000);
	$("div#row",this).hide();
	$(".target1").hide();
	$(".target2").hide();
	$(".target3").hide();
	$(".target4").hide();
$(".target5").hide();
	$(".target6").hide();
	$("#toggle1").click(function(){ 
        $(".target1").slideToggle( 'slow', function(){})
        $(".target1").show();
        $(".target2").hide();
      	$(".target3").hide();
      	$(".target4").hide();
      	$(".target5").hide();
      	$(".target6").hide();
	})
	
	$("#toggle2").click(function(){ 
		$(".target3").hide();
		$(".target4").hide();
		$(".target5").hide();
		$(".target6").hide();
		$(".target2").slideToggle( 'slow', function(){})
        $(".target2").show();
	})
	$("#toggle3").click(function(){ 
		$(".target2").hide();
		$(".target4").hide();
		$(".target5").hide();
		$(".target6").hide();
		$(".target3").slideToggle( 'slow', function(){})
        $(".target3").show();
	})
	$("#toggle4").click(function(){ 
		$(".target5").hide();
		$(".target6").hide();
		$(".target4").slideToggle( 'slow', function(){})
        $(".target4").show();
	})
	$("#toggle5").click(function(){ 
		$(".target4").hide();
		$(".target6").hide();
		$(".target5").slideToggle( 'slow', function(){})
        $(".target5").show();
	})
		$("#toggle6").click(function(){ 
		$(".target4").hide();
		$(".target5").hide();
		$(".target6").slideToggle( 'slow', function(){})
        $(".target6").show();
	})
$("#datepickerID").datepicker({dateFormat:'dd.mm.yy'});
	$("#datepickerID1").datepicker({dateFormat:'dd.mm.yy'});
	$("#datepickerID2").datepicker({dateFormat:'dd.mm.yy'});
	$("#datepickerID3").datepicker({dateFormat:'dd.mm.yy'});
	$("#datepickerID4").datepicker({dateFormat:'dd.mm.yy'});
	$("#datepickerID5").datepicker({dateFormat:'dd.mm.yy'});
	});
function openPage(pageURL)
{
window.location.href = pageURL;
}

</script>
<style>
div#row{
    width:250px;
    height:100px;
    background-color:#F3EF9B;
    position:absolute;
 	cursor:pointer;  
    padding:10px;
    margin:10px;
    font-family: Georgia, serif;
}
</style>

</head>
<body>

<%
Date dat1=new Date();
SimpleDateFormat ft =new SimpleDateFormat("E dd.MM.yyyy 'at' hh:mm:ss a zzz"); 
String date=ft.format(dat1).toString().substring(4,14);
String time=ft.format(dat1).toString().substring(18);


String id=session.getAttribute("userId").toString();
System.out.println("User: "+id);
int flag=0;

Class.forName("oracle.jdbc.driver.OracleDriver");
Connection con=DriverManager.getConnection(""); 
ResultSet result1 = null;
Statement stmt1=con.createStatement();

try{
result1=stmt1.executeQuery("SELECT ID FROM USERS WHERE POWER=1");

		while(result1.next())
		{
  			if(id.equals(result1.getString(1))){
  				flag=1;
  			}
		}
		if(flag==0){
			stmt1.close();
			result1.close();
			response.sendRedirect("datarequest.jsp");
		}
			
}
catch(Exception e)
{
	out.println(e);
}
finally
	{
		stmt1.close();
		result1.close();
	}

%>
<div id="wrapper">
<div id="header">
<div id="logo">
<h1><i>Analytics e-Data Request</i></h1>
</div>
<!-- <div id="slogan">
			<img src="dataReq\sbi-logo.png" width="60%" height="100%"  align="right" />

</div> -->
</div>
<div id="menu" >
<div  align="center">
<ul>
<li><input type="button" class="btn" value="Homepage" onclick="openPage('datarequest.jsp')"/></li>
<li><input type="button" class="btn" id="toggle1" value="Requests" /></li>
<li><input type="button" class="btn"   value="Logout" /></li>
</ul>
</div>
</div>

<div  align="center" class="target1">
<div id="menu2">
<ul>
<li><input type="button" class="btns" value="Status of Request" id="toggle2" /></li>
<!-- <li><input type="button" class="btns" value="Search by Date"  id="toggle3"></li> -->
<li><input type="button" class="btns" value="Search by Date"  onclick="openPage('leaderSearch.jsp')"></li>
</ul>
</div>
</div>

<div  align="center" class="target2">
<div id="menu2">
<ul>
<li>
<input type="button" class="btns" value="Pending with Leader" onclick="openPage('leaderPending.jsp')" />
</li>
<li>
<input type="button" class="btns" value="Forwarded to Admin"  onclick="openPage('leaderRaised.jsp')" />
</li>
<li>
<input type="button" class="btns" value="Assigned to Extractor"  onclick="openPage('leaderAssigned.jsp')" />
</li>
<li><input type="button" class="btns" value="Completed Data Request"  onclick="openPage('leaderComplete.jsp')"/></li>
</ul>
</div>
</div>

<div  align="center" class="target3">
<div id="menu2">
<ul>
<li><input type="button" class="btns" value="GeneratedDate" id="toggle4" /></li>
<li><input type="button" class="btns" value="StartDate" id="toggle5" /></li>
<li><input type="button" class="btns" value="EndDate"  id="toggle6"/></li>
</ul>
</div>
</div>
<div align="center" class="target4" >
<div id="menu2">
<form action="GAdate.jsp" method="post">
<ul>
<li><i>StartDate :</i><input name="Gdates" type="text" id="datepickerID"></li>
<li><i>EndDate :</i><input name="Gdatee"type="text" id="datepickerID1"></li>
<li>
<input type="submit" class="btns" value="submit"></li>
</ul>
</form>
</div>
</div>
<div class="target5" align="center">
<div id="menu2">
<form action="SAdate.jsp" method="post">
<ul>
<li><i>StartDate :</i><input name="Sdates" type="text" id="datepickerID2"></li>
<li><i>EndDate :</i><input  name="Sdatee" type="text" id="datepickerID3"></li>
<li>

<input type="submit" class="btns" value="submit"></li>
</ul>
</form>
</div>
</div>
<div class="target6" align="center">
<div id="menu2">
<form action="EAdate.jsp" method="post">
<ul>
<li><i>StartDate :</i><input type="text" name="Edates" id="datepickerID4"></li>
<li><i>EndDate :</i><input type="text"  name="Edatee"id="datepickerID5"></li>
<li>
<input type="submit" class="btns" value="submit"></li>
</ul>
</form>
</div>
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
<h2 align="center" style="color:blue"><i>Team Leader (<%= session.getAttribute("userName").toString() %>) : Welcome to e-Data Request of Analytics </i></h2>
</div>
<br/>
<div align="center">
<%
ResultSet result = null;
Statement stmt=con.createStatement();

try{
result=stmt.executeQuery("SELECT SUM(PENDING), SUM(RAISED), SUM(ASSIGNED), SUM(COMPLETE) FROM(SELECT ANALYST, NVL(CASE WHEN STATUS=0 THEN COUNT(FILEID) END,0) PENDING,  NVL(CASE WHEN STATUS=1 THEN COUNT(FILEID) END,0) RAISED, NVL(CASE WHEN STATUS=2 THEN COUNT(FILEID) END,0) ASSIGNED, NVL(CASE WHEN STATUS=3 THEN COUNT(FILEID) END,0) COMPLETE FROM REQUESTS WHERE TRIM(LEADER)=TRIM('"+id+"') GROUP BY STATUS, ANALYST)");
%>
<table border="1" width="70%" align="center" id="table">
<tr bgcolor="lightblue"><th>Classification of Requests</th><th>Statistics</th></tr>
<%
while(result.next())
{
%>
<tr><td>No of Requests Pending with Leader</td><td><%= result.getString(1) %></td></tr>
<tr><td>No of Requests Pending with  Admin</td><td><%= result.getString(2) %></td></tr>
<tr><td>No of Requests Pending with  Extractor</td><td><%= result.getString(3) %></td></tr>
<tr><td>No of Requests Completed</td><td><%= result.getString(4) %></td></tr>
<%
}
con.close();
stmt.close();
result.close();

}
catch(Exception e)
{
	out.println(e);
}
finally
	{
		try
		{
		if(con!=null)
		{
			con.close();
		}
		if(stmt!=null)
		{
			stmt.close();
		}
		if(result!=null)
		{
			result.close();
		}
		
		}
		catch(Exception e)
		{}
	}

%>
</table>
</div>
</div>
<div id="page-bottom">
<marquee><h3><i>State Bank of India, Analytics Department</i></h3></marquee>
</div>
</div>
</body>
</html>