<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.sql.*,javax.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<% 
String topic = request.getParameter("download");
java.sql.Connection conn=null;
String query="";
PreparedStatement smt=null;
ResultSet rs=null;
try{
	Class.forName("oracle.jdbc.driver.OracleDriver");
    Connection con=DriverManager.getConnection(""); 
	query="SELECT EXT, FILE1 FROM REQUESTS  WHERE FILEID=?";
	smt=con.prepareStatement(query);
	smt.setString(1,topic);
	rs=smt.executeQuery();
	rs.next();
	response.reset();                        
  	String filename=rs.getString("EXT"); 
 	response.addHeader("Content-Disposition","attachment; filename="+filename);
    Blob blb = rs.getBlob("FILE1");
    byte[] bdata = blb.getBytes(1, (int) blb.length());
    OutputStream output =  response.getOutputStream();
    output.write(bdata);
	output.close();
	rs.close();
    conn.close();
    smt.close();
}
catch(Exception e)
{
out.println(e);	
}
finally
{
	try
	{
		if(conn!=null)
		{
			conn.close();
		}if(smt!=null)
		{
			smt.close();
		}
		if(rs!=null)
		{
			rs.close();
		}
	}
	catch(Exception e)
	{
		
	}
}
 
%>
</body>
</html>