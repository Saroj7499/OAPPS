<%@ page import="java.sql.*"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="Forgot.jsp"%>
<%
	response.setHeader("Cache-Control","no-store"); //HTTP 1.1
	response.setHeader("Pragma","no-cache"); //HTTP 1.0
	response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
	String email=(String)session.getAttribute("email");
	if (email == null) 
	{
		response.sendRedirect("http://localhost:8080/examples/jsp/Forgot.jsp");
	}
	//String a=request.getParameter("email");
	String b=request.getParameter("pass");
	try
	{	
		Class.forName("org.postgresql.Driver");
		Connection con=DriverManager.getConnection("jdbc:postgresql:autohub","postgres","postgres");
		Statement stmt=null;
		Statement stmt2=con.createStatement();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		stmt=con.createStatement();
		rs=stmt.executeQuery("select * from customer where cemail='"+email+"'");
		if(rs.next())
		{
			String query2="update customer set cpwd='"+b+"' where cemail='"+email+"'";
			out.println("<script type=\"text/javascript\">");
			out.println("alert('Password updated!');");
			out.println("location='User.jsp'");
			out.println("</script>");	
			stmt2.executeQuery(query2);
		}
		else
		{
			out.println("<script type=\"text/javascript\">");
			out.println("alert('Invalid details!');");
			out.println("location='Forgot.jsp'");
			out.println("</script>");	
		}
	}
	catch(Exception e){
		out.println("Data is stored");
	}
%>
