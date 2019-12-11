<body bgcolor="#ccddff">
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
	String cat=request.getParameter("cat");
	try
	{	
		Class.forName("org.postgresql.Driver");
		Connection con=DriverManager.getConnection("jdbc:postgresql:autohub","postgres","postgres");
		ResultSet rs=null;
		Statement stmt=null;
		PreparedStatement pstmt=null;
		stmt=con.createStatement();
		rs=stmt.executeQuery("select * from category where category_name='"+cat+"'");
		if(rs.next())
		{
			String query="delete from category where category_name='"+cat+"'";
			pstmt=con.prepareStatement(query);
			pstmt.executeUpdate();
			out.println("<center> <h1> Category Deleted </h1></center>");

		}
		else
		{
			out.println("<center> <h1> This category does not exist</h1> </center>");		
		}
    	}
	catch(Exception e)
	{
		out.println(e);
	}
%>
