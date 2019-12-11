<%@ page import="java.sql.*"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="Admin.jsp"%>
<%@include file="navigation1.html" %>
<%
	response.setHeader("Cache-Control","no-store"); //HTTP 1.1
	response.setHeader("Pragma","no-cache"); //HTTP 1.0
	response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
	String email=(String)session.getAttribute("email");
	if (email == null) 
	{
		response.sendRedirect("http://localhost:8080/examples/jsp/Admin.jsp");
	}
%><!doctype html public"-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Displaying Images</title>
</head>
<body bgcolor="#ccddff">
<p>
<%
	try
{
	
		Class.forName("org.postgresql.Driver");
		Connection con=DriverManager.getConnection("jdbc:postgresql:autohub","postgres","postgres");
PreparedStatement ps=con.prepareStatement("select * from customer");
Statement stmt=con.createStatement();
 ResultSet rs=ps.executeQuery();
%>
</p>

<fieldset>
<legend>Customer Information</legend>
<table border=1>
<tr><th>Customer name</th><th>Phone no.</th><th>Password</th><th>Email</th><th>Address</th></tr>
<%while(rs.next())
{%>
<tr>
<td><%=rs.getString("cname")+"\t"%></td>
<td><%=rs.getString("cphno")+"\t"%></td>
<td><%=rs.getString("cpwd")+"\t"%></td>
<td><%=rs.getString("cemail")+"\t"%></td>
<td><%=rs.getString("caddress")+"\t"%></td>

</tr>
<%}%>
</table>
</fieldset>
<%
}
catch (Exception e)
{
	out.println(e);
}
 %>
</body>
</html>
