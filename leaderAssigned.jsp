<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*" %>
<%@  page import="java.sql.*,javax.sql.*,java.util.Date"%>
<%@ page import="java.text.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>LeaderAssigned</title>
<link rel="stylesheet" type="text/css" href="dataReq/style.css">
<script type="text/javascript" src="dataReq/jquery1x.js"></script>
<script type="text/javascript" src="dataReq/script2.js"></script>
<script type="text/javascript" src="dataReq/jquery-ui.js" ></script>
<link rel="stylesheet" href="dataReq/formStyle.css" type="text/css" />
<script>
$(document).ready(function(){
	$("div#row").hide();
	$("#table td").mouseover(function(){
		$("div#row",this).show();
	}).mouseout(function(){
		$("div#row",this).hide();	
	})
})
function openPage(pageURL)
{
window.location.href = pageURL;
}
</script>
</head>
<body>
<%
Date dat1=new Date();
SimpleDateFormat ft =new SimpleDateFormat("E dd.MM.yyyy 'at' hh:mm:ss a zzz"); 
String date=ft.format(dat1).toString().substring(4,14);
String time=ft.format(dat1).toString().substring(18);

String id=session.getAttribute("userId").toString();
System.out.println("User: "+id);

ResultSet result = null;
Class.forName("oracle.jdbc.driver.OracleDriver");
Connection con=DriverManager.getConnection("jdbc:oracle:thin:@10.4.144.81:1521:ORCL","ora_usr","ora_pwd"); 
Statement stmt=con.createStatement();

try{
result=stmt.executeQuery("SELECT FILEID ,TOPIC ,b.NAME ,c.NAME ,DESCRIPTION, EXT ,CASE WHEN STATUS=0 THEN 'Pending' WHEN STATUS=1 THEN 'Raised' WHEN STATUS=2 THEN 'Assigned' ELSE 'Complete' END, GEN_DT, STRT_DT,d.NAME FROM REQUESTS a, USERS_A b, USERS_L c, USERS_E d WHERE a.ANALYST=b.ID AND a.LEADER=c.ID AND a.EXTRACTOR=d.ID AND STATUS=2 AND TRIM(LEADER)=TRIM('"+id+"') ORDER BY FILEID");

%>
<div id="wrapper">
<div id="header">
<div id="logo">
<h1><i>Analytics e-Data Request</i></h1>
</div>
<!-- <div id="slogan">
			<img src="resources\sbi-logo.png" width="60%" height="100%"  align="right" />

</div> -->
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
<div id="page" align="center">

<table border="1" align="center" id="table" width="100%" style="font-size:12px;">
<tr bgcolor="lightblue">
<td>File Id</td>
<td>Topic</td>
<td>Analyst</td>
<td>Team Leader</td>
<td>Download File</td>
<td>Description</td>
<td>Generated Date</td>
<td>Assigned Date</td>
<td>Extractor</td>
<td>Status</td>

</tr>

<%
while(result.next())
{
%>
<tr>	
<td ><%= result.getString(1) %></td>
<td ><%= result.getString(2) %></td>
<td ><%= result.getString(3) %></td>
<td ><%= result.getString(4) %></td>
<td >
<form action="fileDownload.jsp" method="post">
    			<input type="hidden"  name="download" value="<%= result.getString(1) %>">
    			<input type="submit" value="Download"></form>
</td>
<td > Hover Mouse <div id="row"><%= result.getString(5) %></div></td>
<td ><%= result.getString(8) %></td>
<td ><%= result.getString(9) %></td>
<td ><%= result.getString(10) %></td>
<td bgcolor="blue" style="color:white"><%= result.getString(7) %></td>
</tr>
<% }
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
<br/><br/><br/><br/><br/>
<div id="page-bottom">
<marquee><i>State Bank of India,Analytics Department</i></marquee>
</div>
</div>
</body>
</html>