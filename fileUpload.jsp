<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*" %>
<%@  page import="java.sql.*,javax.sql.*,java.util.Date"%>
<%@ page import="java.text.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>AnalystfileUpload</title>

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
function showPath()
{
	var fil=document.getElementById("file");
	alert(fil.value);
}
</script>
</head>
<body>
<%
	Date dat1=new Date();
	SimpleDateFormat ft =new SimpleDateFormat("E dd.MM.yyyy 'at' hh:mm:ss a zzz"); 
	String date=ft.format(dat1).toString().substring(4,14);
	String time=ft.format(dat1).toString().substring(18);
	ResultSet resultset = null;
	ResultSet resultset1 = null;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	Connection con=DriverManager.getConnection(""); 
	Statement stmt=con.createStatement();
	Statement stmt1=con.createStatement();
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
<li><input type="button" class="btn" value="Homepage" onclick="openPage('analystHome.jsp')"/></li>
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

<h2 align="center"><i>Please Fill The Data Request Form</i></h2>
<form action="UploadServlet" method="post" enctype="multipart/form-data">
<table align="center" width="80%">
<tr>
<td><i>Topic</i></td>
<td></td>
<td><input type="text" value="" name="topic" placeholder="Short Description in 30 words" size="80%"></td>
</tr>
<tr>
<td><i>Team Leader</i>
</td>
<td></td>
<td>
<select name="leader">
<% 
 
try{
	
	resultset=stmt.executeQuery("SELECT ID, NAME FROM USERS WHERE POWER=1");

%>
<option value="none">-----Select Value-----</option>
<%while(resultset.next()){ %>
<option value="<%= resultset.getString(1)%>"><%out.println(resultset.getString(2));%></option>
<%} %>
</select>
</td>
<%	
            }catch (Exception e){
            	System.out.println("Exception :"+e);
            }
            finally{
            	resultset.close();
            	stmt.close();
            }
%>
</tr>
<tr>
<td><i>Analyst</i>
</td>
<td></td>
<td>
<select name="analyst">
<% 
 
try{
	
	resultset1=stmt1.executeQuery("SELECT ID, NAME FROM USERS WHERE POWER=0");

%>
<option value="none">-----Select Value-----</option>
<%while(resultset1.next()){ %>
<option value="<%= resultset1.getString(1)%>"><%out.println(resultset1.getString(2));%></option>
<%} %>
</select>
</td>
<%	
            }catch (Exception e){
            	System.out.println("Exception :"+e);
            }
            finally{
            	resultset1.close();
            	con.close();
            	stmt1.close();
            }
%>
</tr>
<tr>
<td><i>Description</i></td>
<td></td>
<td>
<textarea rows="6" cols="60" name="description" placeholder="Short Description in 300 words" >
</textarea>

</td>
</tr>
<tr>
<td><i>Attachment</i>
</td>
<td>
</td>
<td><input type="file" name="file" id="file" />
</td>
</tr>
<tr>
<td>
</td>
<td></td>
<!-- <td><input type="button" id="file" onClick="showPath();"></td> -->
<td><input type="submit" class="btnB" value="Upload" /></td>
</tr>
</table>
</form>

</div>
<div id="page-bottom">
<marquee><i>State Bank of India,Analytics Department</i></marquee>
</div>
</div>
</body>
</html>