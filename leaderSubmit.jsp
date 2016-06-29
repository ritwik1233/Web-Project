<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    <%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<% 
int fileid=Integer.parseInt(request.getParameter("fileid"));

System.out.println("File Id:"+fileid);

ResultSet resultset = null;
Class.forName("oracle.jdbc.driver.OracleDriver");
Connection con=DriverManager.getConnection(""); 
Statement stmt=con.createStatement(); 

try{
	
	resultset=stmt.executeQuery("UPDATE REQUESTS SET STATUS=1 WHERE FILEID="+fileid);
	
}catch (Exception e){
	System.out.println("Exception :"+e);
}
finally{
	resultset.close();
	con.close();
	stmt.close();
}

response.sendRedirect("leaderPending.jsp");

%>


</body>
</html>