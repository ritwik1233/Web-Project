<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ page import="java.io.*" %>
<%@  page import="java.sql.*,javax.sql.*,java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>GeneratedDateAnalyst</title>

<link rel="stylesheet" type="text/css" href="dataReq/style.css" />
<script type="text/javascript" src="dataReq/jquery1x.js"></script>
<link rel="stylesheet" type="text/css" href="dataReq/formStyle.css" />
<script type="text/javascript">
function openPage(pageURL)
{
window.location.href = pageURL;
}
$(document).ready(function(){
    $("div#row").hide();
    
    $("#table td").mouseover(function(){
       
        $("#row",this).show();
    }).mouseout(function(){
       
        $("#row",this).hide();
    })
    
});
</script>

</head>

<body>
<div id="wrapper">
<div id="header">
<div id="logo">
<h1><i>Analytics e-Data Request</i></h1>
</div>
<!-- <div id="slogan">
			<img src="resources\sbi-logo.png" width="60%" height="100%"  align="right" />

</div> -->
</div>
<div id="menu" align=left>

<input type="submit" class="btn" value="HomePage" onclick="openPage('leaderHome.jsp')" />
</div>

<hr/>

<div id="page" align="center">

<%
String id=session.getAttribute("userId").toString();
System.out.println("User: "+id);

String Start=request.getParameter("Gdates");
String End=request.getParameter("Gdatee");

ResultSet result = null;
Class.forName("oracle.jdbc.driver.OracleDriver");
Connection con=DriverManager.getConnection(""); 
Statement stmt=con.createStatement();

try{
result=stmt.executeQuery("SELECT FILEID ,TOPIC ,ANALYST ,LEADER ,DESCRIPTION, EXT ,CASE WHEN STATUS=0 THEN 'Pending' WHEN STATUS=1 THEN 'Raised' WHEN STATUS=2 THEN 'Assigned' ELSE 'Complete' END, GEN_DT, NVL(STRT_DT,' '), NVL(END_DT,' '), NVL(EXTRACTOR,' ') FROM REQUESTS WHERE TRIM(LEADER)=TRIM('"+id+"') AND GEN_DT BETWEEN '"+Start+"' AND '"+End+"' ORDER BY FILEID");
%>

<table border="1" id="table" width="100%" style="font-size:12px;">
<tr bgcolor="lightblue">
<td>File_Id</td>
<td>Topic</td>
<td>Analyst</td>
<td>Team_Leader</td>
<td>Download_File</td>
<td>Description</td>
<td>Generated_Date</td>
<td>Assigned_Date</td>
<td>Completed_Date</td>
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
<td ><%= result.getString(11) %></td>
<%if(result.getString(7).equals("Pending")){ %>
<td bgcolor="red" style="color:white">
<% }%>
<%if(result.getString(7).equals("Raised")){ %>
<td bgcolor="yellow" style="color:black">
<% }%>
<%if(result.getString(7).equals("Assigned")){ %>
<td bgcolor="blue" style="color:white">
<% }%>
<%if(result.getString(7).equals("Complete")){ %>
<td bgcolor="green" style="color:white">
<% }%>
<%= result.getString(7) %></td>
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
<br/>
<br/>
<br/>
<br/>

<div id="page-bottom">
<marquee><i>State Bank of India,Analytics Department</i></marquee>
</div>
</div>
</body>
</html>