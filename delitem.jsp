<body vLink=#6f6c81 link=#486591 bgcolor="#FFCC99">
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
	int pid=Integer.parseInt(request.getParameter("id"));
	try
	{	
		Class.forName("org.postgresql.Driver");
		Connection con=DriverManager.getConnection("jdbc:postgresql:autohub","postgres","postgres");
		Statement stmt=null;
		Statement stmt2=con.createStatement();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		stmt=con.createStatement();
		rs=stmt.executeQuery("select pid from product where pid="+pid);
		if(rs.next())
		{
			String query1="delete from product where pid="+pid;
			//String query2="update product set deleted=\'yes\' where pid="+pid;
			out.println("<center><h1>Product deleted from catalog</h1></center>");
			stmt2.executeUpdate(query1);
					
		}
		else
		{
			out.print("<center><h1>This product does not exist</h1><center>");
		}
	}
	catch(Exception e){
		out.println(e);
	}
%>
