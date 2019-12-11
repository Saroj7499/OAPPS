<%@ page import="java.sql.*,java.util.*"%>
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
	try
	{
	 //to display report of product wise sale;
	 Class.forName("org.postgresql.Driver");
	 Connection con=DriverManager.getConnection("jdbc:postgresql:autohub","postgres","postgres");
	 PreparedStatement ps=con.prepareStatement("select count(pname), pname from product p,orderdetails od where od.pid=p.pid group by pname");
	 Statement stmt=con.createStatement();
	 ResultSet rs=ps.executeQuery();%>
	 <html><body><form action="#" method="post">
	 <fieldset>
	 <legend>Highest Product sales report</legend>
	 <table border=1><th>count</th><th>product</th>
	 <%while(rs.next())
	 {%>
	 <tr>
	 <td><%=rs.getString("count")%></td>	
	 <td><%=rs.getString("pname")%></td>
	 </tr>
	 <%}%>
	 </table>
	 </fieldset>
	 </form></body></html>
<%}
catch(Exception e)
{ 
	out.println(e);
}
%>
